//
//  String+Extensions.swift
//  OceanComponents
//
//  Created by Leticia Fernandes on 09/03/22.
//

import Foundation
import OceanTokens

public extension String {

    func htmlToAttributedText(font: UIFont = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeXs)!,
                              size: CGFloat,
                              color: UIColor,
                              textAlign: NSTextAlignment = .left) -> NSAttributedString? {
        let htmlTemplate = """
            <!doctype html>
            <html>
              <head>
                <style>
                  body {
                    color: \(color.toHexString!);
                    font-family: '\(font.familyName)',-apple-system;
                    font-size: \(size)px;
                    text-align: \(getAlignValue(textAlign: textAlign));
                  }
                </style>
              </head>
              <body>
                \(self)
              </body>
            </html>
            """

        guard let data = htmlTemplate.data(using: String.Encoding.utf8) else {
            return nil
        }
        guard let attributedString = try? NSAttributedString(data: data,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                                             documentAttributes: nil) else { return nil }
        return attributedString
    }

    private func getAlignValue(textAlign: NSTextAlignment) -> String {
        switch textAlign {
        case .center:
            return "center"
        case .right:
            return "right"
        case .justified:
            return "justify"
        default:
            return "left"
        }
    }

    func extractSupposedBoldWords(completion: @escaping ([String]) -> Void) {
        let query = self
        let regex = try! NSRegularExpression(pattern:"<b>(.*?)</b>", options: [])
        var results = [String]()

        regex.enumerateMatches(in: query, options: [], range: NSMakeRange(0, query.utf16.count)) { result, flags, stop in
            if let r = result?.range(at: 1), let range = Range(r, in: query) {
                results.append(String(query[range]))
            }
            completion(results)
        }

        //Fonte: https://stackoverflow.com/questions/35995942/regex-to-get-string-between-two-characters?rq=1
    }

    /**
        Unifica duas strings que representa uma moeda e um valor financeiro com intuito de não quebrar linha.
     Exemplo:
        R$ 5.000
     Evita acontecer isto:
        R$
        5.0000
     */

    func replaceSpaceWithUnicode() -> String {
        let pat = "\\bR(\\$) \\b"
        let unicode = "R$\u{00A0}"
        let regex = try? NSRegularExpression(pattern: pat)

        return regex?.stringByReplacingMatches(in: self, options: [], range: NSRange(0..<self.count), withTemplate: unicode) ?? self
    }

    func replaceBrTag() -> String {
        return self.replacingOccurrences(of: "</br>", with: "\n").replacingOccurrences(of: "<br>", with: "\n")
    }

    func toStrike() -> NSMutableAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }

    func toOceanColor() -> UIColor {
        switch self.lowercased() {
        case "colorbrandprimarydeep": return Ocean.color.colorBrandPrimaryDeep
        case "colorbrandprimarydown": return Ocean.color.colorBrandPrimaryDown
        case "colorbrandprimarypure": return Ocean.color.colorBrandPrimaryPure
        case "colorbrandprimaryup": return Ocean.color.colorBrandPrimaryUp
        case "colorcomplementarydeep": return Ocean.color.colorComplementaryDeep
        case "colorcomplementarydown": return Ocean.color.colorComplementaryDown
        case "colorcomplementarypure": return Ocean.color.colorComplementaryPure
        case "colorcomplementaryup": return Ocean.color.colorComplementaryUp
        case "colorhighlightdeep": return Ocean.color.colorHighlightDeep
        case "colorhighlightdown": return Ocean.color.colorHighlightDown
        case "colorhighlightpure": return Ocean.color.colorHighlightPure
        case "colorhighlightup": return Ocean.color.colorHighlightUp
        case "colorinterfacedarkdeep": return Ocean.color.colorInterfaceDarkDeep
        case "colorinterfacedarkdown": return Ocean.color.colorInterfaceDarkDown
        case "colorinterfacedarkpure": return Ocean.color.colorInterfaceDarkPure
        case "colorinterfacedarkup": return Ocean.color.colorInterfaceDarkUp
        case "colorinterfacelightdeep": return Ocean.color.colorInterfaceLightDeep
        case "colorinterfacelightdown": return Ocean.color.colorInterfaceLightDown
        case "colorinterfacelightpure": return Ocean.color.colorInterfaceLightPure
        case "colorinterfacelightup": return Ocean.color.colorInterfaceLightUp
        case "colorstatusnegativedeep": return Ocean.color.colorStatusNegativeDeep
        case "colorstatusnegativedown": return Ocean.color.colorStatusNegativeDown
        case "colorstatusnegativepure": return Ocean.color.colorStatusNegativePure
        case "colorstatusnegativeup": return Ocean.color.colorStatusNegativeUp
        case "colorstatusneutraldeep": return Ocean.color.colorStatusNeutralDeep
        case "colorstatusneutraldown": return Ocean.color.colorStatusNeutralDown
        case "colorstatusneutralpure": return Ocean.color.colorStatusNeutralPure
        case "colorstatusneutralup": return Ocean.color.colorStatusNeutralUp
        case "colorstatuspositivedeep": return Ocean.color.colorStatusPositiveDeep
        case "colorstatuspositivedown": return Ocean.color.colorStatusPositiveDown
        case "colorstatuspositivepure": return Ocean.color.colorStatusPositivePure
        case "colorstatuspositiveup": return Ocean.color.colorStatusPositiveUp
        default: return Ocean.color.colorInterfaceDarkDown
        }
    }

    func toOceanIcon() -> UIImage? {
        switch self.lowercased() {
        // BluIcons
        case "appareloutline": return Ocean.icon.apparelOutline
        case "appliancesoutline": return Ocean.icon.appliancesOutline
        case "arrowrightupoutline": return Ocean.icon.arrowRightUpOutline
        case "backgroundoutline": return Ocean.icon.backgroundOutline
        case "barcodebubbleoutline": return Ocean.icon.barcodeBubbleOutline
        case "barcodeoutline": return Ocean.icon.barcodeOutline
        case "bikeoutline": return Ocean.icon.bikeOutline
        case "blulogooutline": return Ocean.icon.BluLogoOutline
        case "btokenoutline": return Ocean.icon.btokenOutline
        case "cardmachineoutline": return Ocean.icon.cardMachineOutline
        case "cashbackoutline": return Ocean.icon.cashbackOutline
        case "constructionmaterialoutline": return Ocean.icon.constructionMaterialOutline
        case "contactbookoutline": return Ocean.icon.contactBookOutline
        case "drugstoreoutline": return Ocean.icon.drugstoreOutline
        case "equaloutline": return Ocean.icon.equalOutline
        case "eventsoutline": return Ocean.icon.eventsOutline
        case "eyeglassstoreoutline": return Ocean.icon.eyeglassStoreOutline
        case "flashoffoutline": return Ocean.icon.flashOffOutline
        case "flashonoutline": return Ocean.icon.flashOnOutline
        case "foodandbeverageoutline": return Ocean.icon.foodAndBeverageOutline
        case "footwareoutline": return Ocean.icon.footwareOutline
        case "furnitureoutline": return Ocean.icon.furnitureOutline
        case "gasstationoutline": return Ocean.icon.gasStationOutline
        case "glassesoutline": return Ocean.icon.glassesOutline
        case "helpoutline": return Ocean.icon.helpOutline
        case "infooutline": return Ocean.icon.infoOutline
        case "instagramoutline": return Ocean.icon.instagramOutline
        case "mattressoutline": return Ocean.icon.mattressOutline
        case "orderoutline": return Ocean.icon.orderOutline
        case "otheroutline": return Ocean.icon.otherOutline
        case "pagbluoutline": return Ocean.icon.pagbluOutline
        case "paperplaneoutline": return Ocean.icon.paperPlaneOutline
        case "paymentoutline": return Ocean.icon.paymentOutline
        case "petshopoutline": return Ocean.icon.petshopOutline
        case "pixoutline": return Ocean.icon.pixOutline
        case "placeholderoutline": return Ocean.icon.placeholderOutline
        case "pointupoutline": return Ocean.icon.pointUpOutline
        case "qrcodedisplayoutline": return Ocean.icon.qrcodeDisplayOutline
        case "rawmaterialoutline": return Ocean.icon.rawMaterialOutline
        case "retaileroutline": return Ocean.icon.retailerOutline
        case "scanoutline": return Ocean.icon.scanOutline
        case "sortoutline": return Ocean.icon.sortOutline
        case "supplieroutline": return Ocean.icon.supplierOutline
        case "taxoutline": return Ocean.icon.taxOutline
        case "warlikeoutline": return Ocean.icon.warlikeOutline
        case "whatsappoutline": return Ocean.icon.whatsappOutline
        case "youtubeoutline": return Ocean.icon.youtubeOutline
        case "zerooutline": return Ocean.icon.zeroOutline
        case "arrowrightupsolid": return Ocean.icon.arrowRightUpSolid
        case "barcodebubblesolid": return Ocean.icon.barcodeBubbleSolid
        case "barcodesolid": return Ocean.icon.barcodeSolid
        case "blulogosolid": return Ocean.icon.BluLogoSolid
        case "equalsolid": return Ocean.icon.equalSolid
        case "flashonsolid": return Ocean.icon.flashOnSolid
        case "glassessolid": return Ocean.icon.glassesSolid
        case "helpsolid": return Ocean.icon.helpSolid
        case "infosolid": return Ocean.icon.infoSolid
        case "instagramsolid": return Ocean.icon.instagramSolid
        case "ordersolid": return Ocean.icon.orderSolid
        case "othersolid": return Ocean.icon.otherSolid
        case "paperplanesolid": return Ocean.icon.paperPlaneSolid
        case "paymentsolid": return Ocean.icon.paymentSolid
        case "pixsolid": return Ocean.icon.pixSolid
        case "placeholdersolid": return Ocean.icon.placeholderSolid
        case "sortsolid": return Ocean.icon.sortSolid
        case "whatsappsolid": return Ocean.icon.whatsappSolid
        case "youtubesolid": return Ocean.icon.youtubeSolid
        // HeroIcons
        case "academiccapoutline": return Ocean.icon.academicCapOutline
        case "academiccapsolid": return Ocean.icon.academicCapSolid
        case "adjustmentsoutline": return Ocean.icon.adjustmentsOutline
        case "adjustmentssolid": return Ocean.icon.adjustmentsSolid
        case "annotationoutline": return Ocean.icon.annotationOutline
        case "annotationsolid": return Ocean.icon.annotationSolid
        case "archiveoutline": return Ocean.icon.archiveOutline
        case "archivesolid": return Ocean.icon.archiveSolid
        case "arrowcircledownoutline": return Ocean.icon.arrowCircleDownOutline
        case "arrowcircledownsolid": return Ocean.icon.arrowCircleDownSolid
        case "arrowcircleleftoutline": return Ocean.icon.arrowCircleLeftOutline
        case "arrowcircleleftsolid": return Ocean.icon.arrowCircleLeftSolid
        case "arrowcirclerightoutline": return Ocean.icon.arrowCircleRightOutline
        case "arrowcirclerightsolid": return Ocean.icon.arrowCircleRightSolid
        case "arrowcircleupoutline": return Ocean.icon.arrowCircleUpOutline
        case "arrowcircleupsolid": return Ocean.icon.arrowCircleUpSolid
        case "arrowdownoutline": return Ocean.icon.arrowDownOutline
        case "arrowdownsolid": return Ocean.icon.arrowDownSolid
        case "arrowleftoutline": return Ocean.icon.arrowLeftOutline
        case "arrowleftsolid": return Ocean.icon.arrowLeftSolid
        case "arrownarrowdownoutline": return Ocean.icon.arrowNarrowDownOutline
        case "arrownarrowdownsolid": return Ocean.icon.arrowNarrowDownSolid
        case "arrownarrowleftoutline": return Ocean.icon.arrowNarrowLeftOutline
        case "arrownarrowleftsolid": return Ocean.icon.arrowNarrowLeftSolid
        case "arrownarrowrightoutline": return Ocean.icon.arrowNarrowRightOutline
        case "arrownarrowrightsolid": return Ocean.icon.arrowNarrowRightSolid
        case "arrownarrowupoutline": return Ocean.icon.arrowNarrowUpOutline
        case "arrownarrowupsolid": return Ocean.icon.arrowNarrowUpSolid
        case "arrowrightoutline": return Ocean.icon.arrowRightOutline
        case "arrowrightsolid": return Ocean.icon.arrowRightSolid
        case "arrowupoutline": return Ocean.icon.arrowUpOutline
        case "arrowupsolid": return Ocean.icon.arrowUpSolid
        case "arrowsexpandoutline": return Ocean.icon.arrowsExpandOutline
        case "arrowsexpandsolid": return Ocean.icon.arrowsExpandSolid
        case "atsymboloutline": return Ocean.icon.atSymbolOutline
        case "atsymbolsolid": return Ocean.icon.atSymbolSolid
        case "backspaceoutline": return Ocean.icon.backspaceOutline
        case "backspacesolid": return Ocean.icon.backspaceSolid
        case "badgecheckoutline": return Ocean.icon.badgeCheckOutline
        case "badgechecksolid": return Ocean.icon.badgeCheckSolid
        case "banoutline": return Ocean.icon.banOutline
        case "bansolid": return Ocean.icon.banSolid
        case "beakeroutline": return Ocean.icon.beakerOutline
        case "beakersolid": return Ocean.icon.beakerSolid
        case "belloutline": return Ocean.icon.bellOutline
        case "bellsolid": return Ocean.icon.bellSolid
        case "bookopenoutline": return Ocean.icon.bookOpenOutline
        case "bookopensolid": return Ocean.icon.bookOpenSolid
        case "bookmarkaltoutline": return Ocean.icon.bookmarkAltOutline
        case "bookmarkaltsolid": return Ocean.icon.bookmarkAltSolid
        case "bookmarkoutline": return Ocean.icon.bookmarkOutline
        case "bookmarksolid": return Ocean.icon.bookmarkSolid
        case "briefcaseoutline": return Ocean.icon.briefcaseOutline
        case "briefcasesolid": return Ocean.icon.briefcaseSolid
        case "cakeoutline": return Ocean.icon.cakeOutline
        case "cakesolid": return Ocean.icon.cakeSolid
        case "calculatoroutline": return Ocean.icon.calculatorOutline
        case "calculatorsolid": return Ocean.icon.calculatorSolid
        case "calendaroutline": return Ocean.icon.calendarOutline
        case "calendarsolid": return Ocean.icon.calendarSolid
        case "cameraoutline": return Ocean.icon.cameraOutline
        case "camerasolid": return Ocean.icon.cameraSolid
        case "cashoutline": return Ocean.icon.cashOutline
        case "cashsolid": return Ocean.icon.cashSolid
        case "chartbaroutline": return Ocean.icon.chartBarOutline
        case "chartbarsolid": return Ocean.icon.chartBarSolid
        case "chartpieoutline": return Ocean.icon.chartPieOutline
        case "chartpiesolid": return Ocean.icon.chartPieSolid
        case "chartsquarebaroutline": return Ocean.icon.chartSquareBarOutline
        case "chartsquarebarsolid": return Ocean.icon.chartSquareBarSolid
        case "chatalt2outline": return Ocean.icon.chatAlt2Outline
        case "chatalt2solid": return Ocean.icon.chatAlt2Solid
        case "chataltoutline": return Ocean.icon.chatAltOutline
        case "chataltsolid": return Ocean.icon.chatAltSolid
        case "chatoutline": return Ocean.icon.chatOutline
        case "chatsolid": return Ocean.icon.chatSolid
        case "checkcircleoutline": return Ocean.icon.checkCircleOutline
        case "checkcirclesolid": return Ocean.icon.checkCircleSolid
        case "checkoutline": return Ocean.icon.checkOutline
        case "checksolid": return Ocean.icon.checkSolid
        case "chevrondoubledownoutline": return Ocean.icon.chevronDoubleDownOutline
        case "chevrondoubledownsolid": return Ocean.icon.chevronDoubleDownSolid
        case "chevrondoubleleftoutline": return Ocean.icon.chevronDoubleLeftOutline
        case "chevrondoubleleftsolid": return Ocean.icon.chevronDoubleLeftSolid
        case "chevrondoublerightoutline": return Ocean.icon.chevronDoubleRightOutline
        case "chevrondoublerightsolid": return Ocean.icon.chevronDoubleRightSolid
        case "chevrondoubleupoutline": return Ocean.icon.chevronDoubleUpOutline
        case "chevrondoubleupsolid": return Ocean.icon.chevronDoubleUpSolid
        case "chevrondownoutline": return Ocean.icon.chevronDownOutline
        case "chevrondownsolid": return Ocean.icon.chevronDownSolid
        case "chevronleftoutline": return Ocean.icon.chevronLeftOutline
        case "chevronleftsolid": return Ocean.icon.chevronLeftSolid
        case "chevronrightoutline": return Ocean.icon.chevronRightOutline
        case "chevronrightsolid": return Ocean.icon.chevronRightSolid
        case "chevronupoutline": return Ocean.icon.chevronUpOutline
        case "chevronupsolid": return Ocean.icon.chevronUpSolid
        case "chipoutline": return Ocean.icon.chipOutline
        case "chipsolid": return Ocean.icon.chipSolid
        case "clipboardcheckoutline": return Ocean.icon.clipboardCheckOutline
        case "clipboardchecksolid": return Ocean.icon.clipboardCheckSolid
        case "clipboardcopyoutline": return Ocean.icon.clipboardCopyOutline
        case "clipboardcopysolid": return Ocean.icon.clipboardCopySolid
        case "clipboardlistoutline": return Ocean.icon.clipboardListOutline
        case "clipboardlistsolid": return Ocean.icon.clipboardListSolid
        case "clipboardoutline": return Ocean.icon.clipboardOutline
        case "clipboardsolid": return Ocean.icon.clipboardSolid
        case "clockoutline": return Ocean.icon.clockOutline
        case "clocksolid": return Ocean.icon.clockSolid
        case "clouddownloadoutline": return Ocean.icon.cloudDownloadOutline
        case "clouddownloadsolid": return Ocean.icon.cloudDownloadSolid
        case "cloudoutline": return Ocean.icon.cloudOutline
        case "cloudsolid": return Ocean.icon.cloudSolid
        case "clouduploadoutline": return Ocean.icon.cloudUploadOutline
        case "clouduploadsolid": return Ocean.icon.cloudUploadSolid
        case "codeoutline": return Ocean.icon.codeOutline
        case "codesolid": return Ocean.icon.codeSolid
        case "cogoutline": return Ocean.icon.cogOutline
        case "cogsolid": return Ocean.icon.cogSolid
        case "collectionoutline": return Ocean.icon.collectionOutline
        case "collectionsolid": return Ocean.icon.collectionSolid
        case "colorswatchoutline": return Ocean.icon.colorSwatchOutline
        case "colorswatchsolid": return Ocean.icon.colorSwatchSolid
        case "creditcardoutline": return Ocean.icon.creditCardOutline
        case "creditcardsolid": return Ocean.icon.creditCardSolid
        case "cubeoutline": return Ocean.icon.cubeOutline
        case "cubesolid": return Ocean.icon.cubeSolid
        case "cubetransparentoutline": return Ocean.icon.cubeTransparentOutline
        case "cubetransparentsolid": return Ocean.icon.cubeTransparentSolid
        case "currencybangladeshioutline": return Ocean.icon.currencyBangladeshiOutline
        case "currencybangladeshisolid": return Ocean.icon.currencyBangladeshiSolid
        case "currencydollaroutline": return Ocean.icon.currencyDollarOutline
        case "currencydollarsolid": return Ocean.icon.currencyDollarSolid
        case "currencyeurooutline": return Ocean.icon.currencyEuroOutline
        case "currencyeurosolid": return Ocean.icon.currencyEuroSolid
        case "currencypoundoutline": return Ocean.icon.currencyPoundOutline
        case "currencypoundsolid": return Ocean.icon.currencyPoundSolid
        case "currencyrupeeoutline": return Ocean.icon.currencyRupeeOutline
        case "currencyrupeesolid": return Ocean.icon.currencyRupeeSolid
        case "currencyyenoutline": return Ocean.icon.currencyYenOutline
        case "currencyyensolid": return Ocean.icon.currencyYenSolid
        case "cursorclickoutline": return Ocean.icon.cursorClickOutline
        case "cursorclicksolid": return Ocean.icon.cursorClickSolid
        case "databaseoutline": return Ocean.icon.databaseOutline
        case "databasesolid": return Ocean.icon.databaseSolid
        case "desktopcomputeroutline": return Ocean.icon.desktopComputerOutline
        case "desktopcomputersolid": return Ocean.icon.desktopComputerSolid
        case "devicemobileoutline": return Ocean.icon.deviceMobileOutline
        case "devicemobilesolid": return Ocean.icon.deviceMobileSolid
        case "devicetabletoutline": return Ocean.icon.deviceTabletOutline
        case "devicetabletsolid": return Ocean.icon.deviceTabletSolid
        case "documentaddoutline": return Ocean.icon.documentAddOutline
        case "documentaddsolid": return Ocean.icon.documentAddSolid
        case "documentdownloadoutline": return Ocean.icon.documentDownloadOutline
        case "documentdownloadsolid": return Ocean.icon.documentDownloadSolid
        case "documentduplicateoutline": return Ocean.icon.documentDuplicateOutline
        case "documentduplicatesolid": return Ocean.icon.documentDuplicateSolid
        case "documentoutline": return Ocean.icon.documentOutline
        case "documentremoveoutline": return Ocean.icon.documentRemoveOutline
        case "documentremovesolid": return Ocean.icon.documentRemoveSolid
        case "documentreportoutline": return Ocean.icon.documentReportOutline
        case "documentreportsolid": return Ocean.icon.documentReportSolid
        case "documentsearchoutline": return Ocean.icon.documentSearchOutline
        case "documentsearchsolid": return Ocean.icon.documentSearchSolid
        case "documentsolid": return Ocean.icon.documentSolid
        case "documenttextoutline": return Ocean.icon.documentTextOutline
        case "documenttextsolid": return Ocean.icon.documentTextSolid
        case "dotscirclehorizontaloutline": return Ocean.icon.dotsCircleHorizontalOutline
        case "dotscirclehorizontalsolid": return Ocean.icon.dotsCircleHorizontalSolid
        case "dotshorizontaloutline": return Ocean.icon.dotsHorizontalOutline
        case "dotshorizontalsolid": return Ocean.icon.dotsHorizontalSolid
        case "dotsverticaloutline": return Ocean.icon.dotsVerticalOutline
        case "dotsverticalsolid": return Ocean.icon.dotsVerticalSolid
        case "downloadoutline": return Ocean.icon.downloadOutline
        case "downloadsolid": return Ocean.icon.downloadSolid
        case "duplicateoutline": return Ocean.icon.duplicateOutline
        case "duplicatesolid": return Ocean.icon.duplicateSolid
        case "emojihappyoutline": return Ocean.icon.emojiHappyOutline
        case "emojihappysolid": return Ocean.icon.emojiHappySolid
        case "emojisadoutline": return Ocean.icon.emojiSadOutline
        case "emojisadsolid": return Ocean.icon.emojiSadSolid
        case "exclamationcircleoutline": return Ocean.icon.exclamationCircleOutline
        case "exclamationcirclesolid": return Ocean.icon.exclamationCircleSolid
        case "exclamationoutline": return Ocean.icon.exclamationOutline
        case "exclamationsolid": return Ocean.icon.exclamationSolid
        case "externallinkoutline": return Ocean.icon.externalLinkOutline
        case "externallinksolid": return Ocean.icon.externalLinkSolid
        case "eyeoffoutline": return Ocean.icon.eyeOffOutline
        case "eyeoffsolid": return Ocean.icon.eyeOffSolid
        case "eyeoutline": return Ocean.icon.eyeOutline
        case "eyesolid": return Ocean.icon.eyeSolid
        case "fastforwardoutline": return Ocean.icon.fastForwardOutline
        case "fastforwardsolid": return Ocean.icon.fastForwardSolid
        case "filmoutline": return Ocean.icon.filmOutline
        case "filmsolid": return Ocean.icon.filmSolid
        case "filteroutline": return Ocean.icon.filterOutline
        case "filtersolid": return Ocean.icon.filterSolid
        case "fingerprintoutline": return Ocean.icon.fingerPrintOutline
        case "fingerprintsolid": return Ocean.icon.fingerPrintSolid
        case "fireoutline": return Ocean.icon.fireOutline
        case "firesolid": return Ocean.icon.fireSolid
        case "flagoutline": return Ocean.icon.flagOutline
        case "flagsolid": return Ocean.icon.flagSolid
        case "folderaddoutline": return Ocean.icon.folderAddOutline
        case "folderaddsolid": return Ocean.icon.folderAddSolid
        case "folderdownloadoutline": return Ocean.icon.folderDownloadOutline
        case "folderdownloadsolid": return Ocean.icon.folderDownloadSolid
        case "folderopenoutline": return Ocean.icon.folderOpenOutline
        case "folderopensolid": return Ocean.icon.folderOpenSolid
        case "folderoutline": return Ocean.icon.folderOutline
        case "folderremoveoutline": return Ocean.icon.folderRemoveOutline
        case "folderremovesolid": return Ocean.icon.folderRemoveSolid
        case "foldersolid": return Ocean.icon.folderSolid
        case "giftoutline": return Ocean.icon.giftOutline
        case "giftsolid": return Ocean.icon.giftSolid
        case "globealtoutline": return Ocean.icon.globeAltOutline
        case "globealtsolid": return Ocean.icon.globeAltSolid
        case "globeoutline": return Ocean.icon.globeOutline
        case "globesolid": return Ocean.icon.globeSolid
        case "handoutline": return Ocean.icon.handOutline
        case "handsolid": return Ocean.icon.handSolid
        case "hashtagoutline": return Ocean.icon.hashtagOutline
        case "hashtagsolid": return Ocean.icon.hashtagSolid
        case "heartoutline": return Ocean.icon.heartOutline
        case "heartsolid": return Ocean.icon.heartSolid
        case "homeoutline": return Ocean.icon.homeOutline
        case "homesolid": return Ocean.icon.homeSolid
        case "identificationoutline": return Ocean.icon.identificationOutline
        case "identificationsolid": return Ocean.icon.identificationSolid
        case "inboxinoutline": return Ocean.icon.inboxInOutline
        case "inboxinsolid": return Ocean.icon.inboxInSolid
        case "inboxoutline": return Ocean.icon.inboxOutline
        case "inboxsolid": return Ocean.icon.inboxSolid
        case "informationcircleoutline": return Ocean.icon.informationCircleOutline
        case "informationcirclesolid": return Ocean.icon.informationCircleSolid
        case "keyoutline": return Ocean.icon.keyOutline
        case "keysolid": return Ocean.icon.keySolid
        case "libraryoutline": return Ocean.icon.libraryOutline
        case "librarysolid": return Ocean.icon.librarySolid
        case "lightbulboutline": return Ocean.icon.lightBulbOutline
        case "lightbulbsolid": return Ocean.icon.lightBulbSolid
        case "lightningboltoutline": return Ocean.icon.lightningBoltOutline
        case "lightningboltsolid": return Ocean.icon.lightningBoltSolid
        case "linkoutline": return Ocean.icon.linkOutline
        case "linksolid": return Ocean.icon.linkSolid
        case "locationmarkeroutline": return Ocean.icon.locationMarkerOutline
        case "locationmarkersolid": return Ocean.icon.locationMarkerSolid
        case "lockclosedoutline": return Ocean.icon.lockClosedOutline
        case "lockclosedsolid": return Ocean.icon.lockClosedSolid
        case "lockopenoutline": return Ocean.icon.lockOpenOutline
        case "lockopensolid": return Ocean.icon.lockOpenSolid
        case "loginoutline": return Ocean.icon.loginOutline
        case "loginsolid": return Ocean.icon.loginSolid
        case "logoutoutline": return Ocean.icon.logoutOutline
        case "logoutsolid": return Ocean.icon.logoutSolid
        case "mailopenoutline": return Ocean.icon.mailOpenOutline
        case "mailopensolid": return Ocean.icon.mailOpenSolid
        case "mailoutline": return Ocean.icon.mailOutline
        case "mailsolid": return Ocean.icon.mailSolid
        case "mapoutline": return Ocean.icon.mapOutline
        case "mapsolid": return Ocean.icon.mapSolid
        case "menualt1outline": return Ocean.icon.menuAlt1Outline
        case "menualt1solid": return Ocean.icon.menuAlt1Solid
        case "menualt2outline": return Ocean.icon.menuAlt2Outline
        case "menualt2solid": return Ocean.icon.menuAlt2Solid
        case "menualt3outline": return Ocean.icon.menuAlt3Outline
        case "menualt3solid": return Ocean.icon.menuAlt3Solid
        case "menualt4outline": return Ocean.icon.menuAlt4Outline
        case "menualt4solid": return Ocean.icon.menuAlt4Solid
        case "menuoutline": return Ocean.icon.menuOutline
        case "menusolid": return Ocean.icon.menuSolid
        case "microphoneoutline": return Ocean.icon.microphoneOutline
        case "microphonesolid": return Ocean.icon.microphoneSolid
        case "minuscircleoutline": return Ocean.icon.minusCircleOutline
        case "minuscirclesolid": return Ocean.icon.minusCircleSolid
        case "minusoutline": return Ocean.icon.minusOutline
        case "minussmoutline": return Ocean.icon.minusSmOutline
        case "minussmsolid": return Ocean.icon.minusSmSolid
        case "minussolid": return Ocean.icon.minusSolid
        case "moonoutline": return Ocean.icon.moonOutline
        case "moonsolid": return Ocean.icon.moonSolid
        case "musicnoteoutline": return Ocean.icon.musicNoteOutline
        case "musicnotesolid": return Ocean.icon.musicNoteSolid
        case "newspaperoutline": return Ocean.icon.newspaperOutline
        case "newspapersolid": return Ocean.icon.newspaperSolid
        case "officebuildingoutline": return Ocean.icon.officeBuildingOutline
        case "officebuildingsolid": return Ocean.icon.officeBuildingSolid
        case "paperairplaneoutline": return Ocean.icon.paperAirplaneOutline
        case "paperairplanesolid": return Ocean.icon.paperAirplaneSolid
        case "paperclipoutline": return Ocean.icon.paperClipOutline
        case "paperclipsolid": return Ocean.icon.paperClipSolid
        case "pauseoutline": return Ocean.icon.pauseOutline
        case "pausesolid": return Ocean.icon.pauseSolid
        case "pencilaltoutline": return Ocean.icon.pencilAltOutline
        case "pencilaltsolid": return Ocean.icon.pencilAltSolid
        case "penciloutline": return Ocean.icon.pencilOutline
        case "pencilsolid": return Ocean.icon.pencilSolid
        case "phoneincomingoutline": return Ocean.icon.phoneIncomingOutline
        case "phoneincomingsolid": return Ocean.icon.phoneIncomingSolid
        case "phonemissedcalloutline": return Ocean.icon.phoneMissedCallOutline
        case "phonemissedcallsolid": return Ocean.icon.phoneMissedCallSolid
        case "phoneoutgoingoutline": return Ocean.icon.phoneOutgoingOutline
        case "phoneoutgoingsolid": return Ocean.icon.phoneOutgoingSolid
        case "phoneoutline": return Ocean.icon.phoneOutline
        case "phonesolid": return Ocean.icon.phoneSolid
        case "photographoutline": return Ocean.icon.photographOutline
        case "photographsolid": return Ocean.icon.photographSolid
        case "playoutline": return Ocean.icon.playOutline
        case "playsolid": return Ocean.icon.playSolid
        case "pluscircleoutline": return Ocean.icon.plusCircleOutline
        case "pluscirclesolid": return Ocean.icon.plusCircleSolid
        case "plusoutline": return Ocean.icon.plusOutline
        case "plussmoutline": return Ocean.icon.plusSmOutline
        case "plussmsolid": return Ocean.icon.plusSmSolid
        case "plussolid": return Ocean.icon.plusSolid
        case "presentationchartbaroutline": return Ocean.icon.presentationChartBarOutline
        case "presentationchartbarsolid": return Ocean.icon.presentationChartBarSolid
        case "presentationchartlineoutline": return Ocean.icon.presentationChartLineOutline
        case "presentationchartlinesolid": return Ocean.icon.presentationChartLineSolid
        case "printeroutline": return Ocean.icon.printerOutline
        case "printersolid": return Ocean.icon.printerSolid
        case "puzzleoutline": return Ocean.icon.puzzleOutline
        case "puzzlesolid": return Ocean.icon.puzzleSolid
        case "qrcodeoutline": return Ocean.icon.qrcodeOutline
        case "qrcodesolid": return Ocean.icon.qrcodeSolid
        case "questionmarkcircleoutline": return Ocean.icon.questionMarkCircleOutline
        case "questionmarkcirclesolid": return Ocean.icon.questionMarkCircleSolid
        case "receiptrefundoutline": return Ocean.icon.receiptRefundOutline
        case "receiptrefundsolid": return Ocean.icon.receiptRefundSolid
        case "receipttaxoutline": return Ocean.icon.receiptTaxOutline
        case "receipttaxsolid": return Ocean.icon.receiptTaxSolid
        case "refreshoutline": return Ocean.icon.refreshOutline
        case "refreshsolid": return Ocean.icon.refreshSolid
        case "replyoutline": return Ocean.icon.replyOutline
        case "replysolid": return Ocean.icon.replySolid
        case "rewindoutline": return Ocean.icon.rewindOutline
        case "rewindsolid": return Ocean.icon.rewindSolid
        case "rssoutline": return Ocean.icon.rssOutline
        case "rsssolid": return Ocean.icon.rssSolid
        case "saveasoutline": return Ocean.icon.saveAsOutline
        case "saveassolid": return Ocean.icon.saveAsSolid
        case "saveoutline": return Ocean.icon.saveOutline
        case "savesolid": return Ocean.icon.saveSolid
        case "scaleoutline": return Ocean.icon.scaleOutline
        case "scalesolid": return Ocean.icon.scaleSolid
        case "scissorsoutline": return Ocean.icon.scissorsOutline
        case "scissorssolid": return Ocean.icon.scissorsSolid
        case "searchcircleoutline": return Ocean.icon.searchCircleOutline
        case "searchcirclesolid": return Ocean.icon.searchCircleSolid
        case "searchoutline": return Ocean.icon.searchOutline
        case "searchsolid": return Ocean.icon.searchSolid
        case "selectoroutline": return Ocean.icon.selectorOutline
        case "selectorsolid": return Ocean.icon.selectorSolid
        case "serveroutline": return Ocean.icon.serverOutline
        case "serversolid": return Ocean.icon.serverSolid
        case "shareoutline": return Ocean.icon.shareOutline
        case "sharesolid": return Ocean.icon.shareSolid
        case "shieldcheckoutline": return Ocean.icon.shieldCheckOutline
        case "shieldchecksolid": return Ocean.icon.shieldCheckSolid
        case "shieldexclamationoutline": return Ocean.icon.shieldExclamationOutline
        case "shieldexclamationsolid": return Ocean.icon.shieldExclamationSolid
        case "shoppingbagoutline": return Ocean.icon.shoppingBagOutline
        case "shoppingbagsolid": return Ocean.icon.shoppingBagSolid
        case "shoppingcartoutline": return Ocean.icon.shoppingCartOutline
        case "shoppingcartsolid": return Ocean.icon.shoppingCartSolid
        case "sortascendingoutline": return Ocean.icon.sortAscendingOutline
        case "sortascendingsolid": return Ocean.icon.sortAscendingSolid
        case "sortdescendingoutline": return Ocean.icon.sortDescendingOutline
        case "sortdescendingsolid": return Ocean.icon.sortDescendingSolid
        case "sparklesoutline": return Ocean.icon.sparklesOutline
        case "sparklessolid": return Ocean.icon.sparklesSolid
        case "speakerphoneoutline": return Ocean.icon.speakerphoneOutline
        case "speakerphonesolid": return Ocean.icon.speakerphoneSolid
        case "staroutline": return Ocean.icon.starOutline
        case "starsolid": return Ocean.icon.starSolid
        case "statusofflineoutline": return Ocean.icon.statusOfflineOutline
        case "statusofflinesolid": return Ocean.icon.statusOfflineSolid
        case "statusonlineoutline": return Ocean.icon.statusOnlineOutline
        case "statusonlinesolid": return Ocean.icon.statusOnlineSolid
        case "stopoutline": return Ocean.icon.stopOutline
        case "stopsolid": return Ocean.icon.stopSolid
        case "sunoutline": return Ocean.icon.sunOutline
        case "sunsolid": return Ocean.icon.sunSolid
        case "supportoutline": return Ocean.icon.supportOutline
        case "supportsolid": return Ocean.icon.supportSolid
        case "switchhorizontaloutline": return Ocean.icon.switchHorizontalOutline
        case "switchhorizontalsolid": return Ocean.icon.switchHorizontalSolid
        case "switchverticaloutline": return Ocean.icon.switchVerticalOutline
        case "switchverticalsolid": return Ocean.icon.switchVerticalSolid
        case "tableoutline": return Ocean.icon.tableOutline
        case "tablesolid": return Ocean.icon.tableSolid
        case "tagoutline": return Ocean.icon.tagOutline
        case "tagsolid": return Ocean.icon.tagSolid
        case "templateoutline": return Ocean.icon.templateOutline
        case "templatesolid": return Ocean.icon.templateSolid
        case "terminaloutline": return Ocean.icon.terminalOutline
        case "terminalsolid": return Ocean.icon.terminalSolid
        case "thumbdownoutline": return Ocean.icon.thumbDownOutline
        case "thumbdownsolid": return Ocean.icon.thumbDownSolid
        case "thumbupoutline": return Ocean.icon.thumbUpOutline
        case "thumbupsolid": return Ocean.icon.thumbUpSolid
        case "ticketoutline": return Ocean.icon.ticketOutline
        case "ticketsolid": return Ocean.icon.ticketSolid
        case "translateoutline": return Ocean.icon.translateOutline
        case "translatesolid": return Ocean.icon.translateSolid
        case "trashoutline": return Ocean.icon.trashOutline
        case "trashsolid": return Ocean.icon.trashSolid
        case "trendingdownoutline": return Ocean.icon.trendingDownOutline
        case "trendingdownsolid": return Ocean.icon.trendingDownSolid
        case "trendingupoutline": return Ocean.icon.trendingUpOutline
        case "trendingupsolid": return Ocean.icon.trendingUpSolid
        case "truckoutline": return Ocean.icon.truckOutline
        case "trucksolid": return Ocean.icon.truckSolid
        case "uploadoutline": return Ocean.icon.uploadOutline
        case "uploadsolid": return Ocean.icon.uploadSolid
        case "useraddoutline": return Ocean.icon.userAddOutline
        case "useraddsolid": return Ocean.icon.userAddSolid
        case "usercircleoutline": return Ocean.icon.userCircleOutline
        case "usercirclesolid": return Ocean.icon.userCircleSolid
        case "usergroupoutline": return Ocean.icon.userGroupOutline
        case "usergroupsolid": return Ocean.icon.userGroupSolid
        case "useroutline": return Ocean.icon.userOutline
        case "userremoveoutline": return Ocean.icon.userRemoveOutline
        case "userremovesolid": return Ocean.icon.userRemoveSolid
        case "usersolid": return Ocean.icon.userSolid
        case "usersoutline": return Ocean.icon.usersOutline
        case "userssolid": return Ocean.icon.usersSolid
        case "variableoutline": return Ocean.icon.variableOutline
        case "variablesolid": return Ocean.icon.variableSolid
        case "videocameraoutline": return Ocean.icon.videoCameraOutline
        case "videocamerasolid": return Ocean.icon.videoCameraSolid
        case "viewboardsoutline": return Ocean.icon.viewBoardsOutline
        case "viewboardssolid": return Ocean.icon.viewBoardsSolid
        case "viewgridaddoutline": return Ocean.icon.viewGridAddOutline
        case "viewgridaddsolid": return Ocean.icon.viewGridAddSolid
        case "viewgridoutline": return Ocean.icon.viewGridOutline
        case "viewgridsolid": return Ocean.icon.viewGridSolid
        case "viewlistoutline": return Ocean.icon.viewListOutline
        case "viewlistsolid": return Ocean.icon.viewListSolid
        case "volumeoffoutline": return Ocean.icon.volumeOffOutline
        case "volumeoffsolid": return Ocean.icon.volumeOffSolid
        case "volumeupoutline": return Ocean.icon.volumeUpOutline
        case "volumeupsolid": return Ocean.icon.volumeUpSolid
        case "wifioutline": return Ocean.icon.wifiOutline
        case "wifisolid": return Ocean.icon.wifiSolid
        case "xcircleoutline": return Ocean.icon.xCircleOutline
        case "xcirclesolid": return Ocean.icon.xCircleSolid
        case "xoutline": return Ocean.icon.xOutline
        case "xsolid": return Ocean.icon.xSolid
        case "zoominoutline": return Ocean.icon.zoomInOutline
        case "zoominsolid": return Ocean.icon.zoomInSolid
        case "zoomoutoutline": return Ocean.icon.zoomOutOutline
        case "zoomoutsolid": return Ocean.icon.zoomOutSolid
        default: return nil
        }
    }
}
