Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E691C433F5
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Jan 2022 01:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbiAGBCO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 6 Jan 2022 20:02:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:27800 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236544AbiAGBCO (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jan 2022 20:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641517334; x=1673053334;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=YD8bi0JFHDT8bjwNGFz5TQ4LVyvLEEUzsWMDDHtkbEs=;
  b=Owwc2k7rW+Tu03D0HfoQVSxBy3xjSV0DBkGT+iXliHvwwnsUqh57WaPO
   H2/OrWIg8x3oyc0zpL3cW88s+DmCJRatM4UgYkDztf4mZG9DXix7BYoUf
   ajPjkvWYkH6g+kCZy5UMkelmR8HzzOGWGxvrB585GFRxkmIo57brtRcE+
   GBpfD/vpehtju7COhzGXWv7ZFLPvpq6ukocDEoZRrPz3bxIRb/WnWBXx+
   x5MM8YPC1d6MPqCf+i3EuFfk97l2fo9M7dTYtd4mUM59kp4l8XHwAXO9G
   VNfxjqWlTcdTjaxrCVfCme4ViMHmB+Nhr35IPiYlyrSvfuPm9Goqyw+SX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="306145435"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="306145435"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 17:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="591563225"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2022 17:02:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 17:02:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 17:02:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 17:02:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 17:02:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D56CdAuUYxD+MDEZGv/cpoP8WCIGXhotlp5GNsQ0ZC5PA+cF1z4ojYghYo5uEwUEp4tD6dr7OZ3NrCwA3dfH2Ob5OPgOqTPdnCsEeYwEwAwMoPbPxcaM4xwTj3QPW2LSefOt/3Jg/OmCVG3VpqRK2Owp6F/TD4gFnc0yJ2kQDzbEpzIXKLPuJ1vXjttnyLfqZzR8YnSu/cEYYYOhIksBk3P2HQKNN1jsKn93L0U0fvARYODKBXS+/HIz+1ZtIZldJFQzIsmT6ywgu+7ql1ZW2qC98x70pXQBRDt4gdtx1J0THQEeROTPQJ5KzTrxnHh9ltK0eupY/A94w4bG4zuLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD8bi0JFHDT8bjwNGFz5TQ4LVyvLEEUzsWMDDHtkbEs=;
 b=nUFhoNoLuR+YA/T0FGY4Le+ztunuX4yKf50qRLRWJExYgyVKhtwAfodCng81BMTF8LtCwOY7FYi6/Di8e/hvPJEmr3Ue+V6VDAJ2n0qs/CEKQHxq/GZdOmM2mHPmk3iap5YUrp4YtEvhy02ECRc3D9s7PRCOi83bRD5bxccRD0VzbMrWOYcbPIL5cJg4FbrbgELO0fZOrYABMjKHEkB9BoC3M8dFWGBCUwloheaI1KQ0SJioUXdsHTG29bfJP0EDZkhIQMFXzT0K1ovXxUgmZr7KgP487eQ1rovRADseDHZ44mPCL9TDz53d0ZXk/Sa5uDqXlgihtpxQUO/7w3hcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 01:02:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2986:f32f:617b:6b76]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2986:f32f:617b:6b76%9]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 01:02:11 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: array of flexible structures oddity
Thread-Topic: array of flexible structures oddity
Thread-Index: AQHYA2IzNRRn4MGCckumf85BE+YiNg==
Date:   Fri, 7 Jan 2022 01:02:11 +0000
Message-ID: <64238376-3882-2449-7758-e948cb4a6e1c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 803e239d-6f3c-48d6-b12c-08d9d1795629
x-ms-traffictypediagnostic: CO1PR11MB4834:EE_
x-microsoft-antispam-prvs: <CO1PR11MB48340B4A0C369421F98D439FD64D9@CO1PR11MB4834.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vM2Ve1EpV7yhoH7wkYBahm5JPrtY2sKyDMJRHYPorrU09eiTZxliw6h+XCEJSyXMM2WzSXSwUbrjQLj31+TXI5urW/PjCOVGLlloiSlJ1nSwIUE0ikcG8VaHceYkMVLcc2aoUPdZB4hTo3sclzYNHnr7Mf1FnlK/xV4I7H90aB/kTzk5TU7MjR76TKvQNdaImByUN9grvIJ4z9J21CAPrFZxI1z7Ggv37qZBB07W5rEuOfV2ROz8RL9q/zlSrycur6odOU8apggo0DT+VAqwcmlRQ5TARenaBoB7GTwFYjnfBdh5uALp7ZvGDam/oVpaM6Bw8IrJTt7v55T2sGhfGPzikUqlm1mfXwL+9+wSdERPjgoMu3SHnzgCpigXVLond/r4fdNpm3tsxQrqgkTMGM5NPivzqPxIcGv870ZL9t7A1Noa860SH1luYyH/Oncd/6HMKmZ8w6jpSJlgqk2GKyAfD8xhYcTHKQgf471H0bCecQCYWR+a2VregscmO/TFnmhoA3R74N9LduPq+1o6VErQiIzB+Y2dLfOWLmrb/96daB3TF1HJMnp1w3ZMEyV5quJkfZNT/MfU1reK1ZdrdyBkhXU4ORcxMUeAO1zZU9ly0X6scRzM/e7wVDSEfg1HPeN7ugoKoV9I8I2/h2h/a/B6YPOLqyx8EDguhQjRT0Y5dWbjuEvHa2EsL2rzeD3binJmdfgmPRw3WLawcvZFNTrI4H671zwNMVdAcTJ5zymxQO/9bmAE3IZYkDh6QGu2whVMrFSD+C9JpbXojUaHYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(6506007)(5660300002)(6486002)(122000001)(82960400001)(2906002)(71200400001)(83380400001)(6512007)(66946007)(66476007)(31696002)(64756008)(66556008)(508600001)(66446008)(31686004)(26005)(8676002)(38100700002)(8936002)(36756003)(186003)(38070700005)(316002)(2616005)(86362001)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0w5MFI4OVU3ZXkxZm1DbG1DTWY2dUNVOXBOWHFOWWxZa0JSbCsyUm5aMkEw?=
 =?utf-8?B?WFpiT1hvQk9XRVp2VnhKbU9TTkY2ZldVVXlpcHRlMWIwUkczL3pJZStkM3VY?=
 =?utf-8?B?ME9mM2dKelVTOVdla2RVS1R4NDA5TDMva1NjV0gwTnpISXZHK0FrWEZ2NUYr?=
 =?utf-8?B?bXBmSklJcWpUdWlLSktISUs3Y2d6OWNqa0lQd1FHcFpIY3l4aVNFZlFMVnBk?=
 =?utf-8?B?UFBRMnl3emNoVGd2OFp1aG5vbGhHOGdocjN0bzgwcU9qZ1dnanRmU0dSU0p1?=
 =?utf-8?B?ZCtocC96TVIrUklSRDAyb0VteEVvK0F2NHU5Q0J2Z1llTTFJUHg5bDdkVWl4?=
 =?utf-8?B?Um1scG9DSW5td1lQNnBNUlpRUXNMTG5PamVsb2llUkZlYTBWUXlPWTVCa2hs?=
 =?utf-8?B?Y2VMU0RBYW1ncEVHeEhTYWx4Nm4xN0MzQkF3WDFQRGQrbTRyK09iTmRwa1hD?=
 =?utf-8?B?ZjUyREhzTXVwZi9meDBlRVVjS0ZCNFh4ZnhqdS9YN3BPWmpwSTkzcG93QzVa?=
 =?utf-8?B?cGo1eDBaemp3bUhOb3pvRlpFRlBWU2Jiek1LYzdkUGdSVmhUQlZKK0krWUpY?=
 =?utf-8?B?b2IrTko4ZkFxc2E4TmwrNlVRMHdiUGhPZWhLYmhmOU5GeCtIVzM3OFdtUm1v?=
 =?utf-8?B?cUVyN244WGtEaE5QZ2gyRkFsSlZGZitkc09STE4raWQyamk3NXUvMGRXa2Ny?=
 =?utf-8?B?VDJCVks3djFSNG1TcUJMWnordHNDYmYzRkFsd3pNRGRrV1FwMUkvKzM5WXdQ?=
 =?utf-8?B?VXk2bHFVaXZDNElXNnNSUHRxWjNoNk1JR1VkY1ZmdkFMZTJMT3laOHN1Nkxv?=
 =?utf-8?B?UVJTZ1REeE5zSFAwNm1XRWZZMnQ1OTNvNU5uK1hpbG9IMU50QnU2NURMVnRC?=
 =?utf-8?B?azRQSmZSdGpHMXZjWGNiYWw3Zi9VSTN0RW8vdENpOW02MEwwSU1obURRWEVx?=
 =?utf-8?B?WTVoblVNaHJ5Uk9rVExsRWVaYS9lSDdiV2hwVklWVWlsRU5KQnRmY1dIZFRy?=
 =?utf-8?B?UksxcEg4dEQ3cGpJL002T3lXUnQyUjVNcjZ2My9kMnI3ZWVhMjFrWWZTbEFo?=
 =?utf-8?B?VEJ0VEZhY3RTc3lROWhQc09TemE3OU5qblVRblZUbTZqbnRvSGpVbDdVNlZZ?=
 =?utf-8?B?NVQxSXg2QWJQeWVjVEFORFN4QnpkMWwrQi8zb25Xa2RsdXMxWUN3RHQ0SFdQ?=
 =?utf-8?B?eXYwRHdzRW9RcUh1TjN4TTRnOXZ3Z0l0c3A3dUFrQjRhS2g3SU90ZG4xMEsx?=
 =?utf-8?B?NUpnK1Jyd1MrZmdaeHdITENZZWVBRmJiSUJVNUQzelFjaTdOcHFmdlhOcW9E?=
 =?utf-8?B?b3hXalM3OXJmQnh3aVBTdHIvRUovU1pVVzFKM0krTzJvbjhJR1lHUExsUjky?=
 =?utf-8?B?SUxVY1YxMDJHOGUyKy9MN0ZDMVVKWUZVVWZBMVhBdXBFMUx4WWxNT1RZWXZZ?=
 =?utf-8?B?MzJLRmxWeDhQYUNqc05mcEdXZnVLZzErMUVXZzJsSEVPbkdqQWs4VzFtTGNC?=
 =?utf-8?B?UUk3YUVLSE9lcEMyWldNWUZPUndBZXgzeVJjdHplbFh2WUhmNTBzeXFydk1G?=
 =?utf-8?B?QW5ScWJBM0RzVEZselk1WWtIUy9zNGF4NmNPRXdCYTZMS1Myd0dEUmU4U3hV?=
 =?utf-8?B?em8zN2FvcEV3cTA3WlZ1aEViMUVjdEU2b1d4Y29HT1lnZDhIS1RQanhOOUtx?=
 =?utf-8?B?L3ZwcTN4RllwbnIxRjlxa2VtUEhXMUxKemtXblZTRjZOQTlUVCt6YjBxeGlq?=
 =?utf-8?B?bW9FcVc0NFExa1MvUURLMm9EMG02Q3NaUDRhVkJMaXhXTFovckMzSVlWUnhn?=
 =?utf-8?B?L01VREFNSG1sZy96M04rSjFzeXJjTmU5NmJJQXZ4dVhSMnVJc2o3YkNmUW11?=
 =?utf-8?B?Ry96azVvSlYzK2pMVjl0enptM1NqVkNsNk9nRzhMZW84RksyenZrRG9zY0JN?=
 =?utf-8?B?VzA1T3ZjWHdYQjgvRmFJRFVEQWlZV3Q0U0Y1ZjFzbmg0dDlrdnplT2pKY3pz?=
 =?utf-8?B?SVNqTzM4S3RMWUJSYWFLVytYQytvWlhUTGxNVDRGVkp4U1dld1FzM3R4dGRB?=
 =?utf-8?B?Q1g3OEhMVEVjb0ZIVUlUQldLWGNqN3RoWHdGWURwdkoyOU1VWVU3NzRKbm1X?=
 =?utf-8?B?TnpXVUlqRExFODEwSDhLMHd3c2RFZW9TZmQ5UHBMSERyL3lwZ01zSEFYaTli?=
 =?utf-8?Q?AT2V5fxgPPqqlDlxpYQHrK5kdN4IUR3BQuKWRAwmDpyd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EF41631B280744D98DC3B39244E402C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803e239d-6f3c-48d6-b12c-08d9d1795629
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 01:02:11.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PC3khs3W0QWOdTYlxx4NdV7l352YOFfwHAZr5/IevuFDrT1CwmLZZBBt2B5XBPSnhilrkfCW4lRTvtfQ/SJiKjLIMnJEF76BocKyQpIkGY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

SGksDQoNCkknbSB3b3JraW5nIG9uIHNvbWUgY29kZSBhbmQgbm90aWNlZCB0aGF0IHNwYXJzZSB2
MC42LjQgbm93IGNvbXBsYWlucw0KYWJvdXQgYSBzZWVtaW5nbHkgaW5ub2N1b3VzIHVzZSBvZiAi
dHR5X3BvcnQiIGZyb20gdGhlIExpbnV4IGtlcm5lbDoNCg0Kc3RydWN0IG15X3N0cnVjdCB7DQog
ICAgc3RydWN0IHR0eV9wb3J0WzVdOw0KfQ0KDQpUaGlzIG9jY3VycyBiZWNhdXNlIHRoZSB0dHlf
cG9ydCBzdHJ1Y3R1cmUgY29udGFpbnMgYSB0dHlfYnVmaGVhZCB3aGljaA0KaXRzZWxmIGNvbnRh
aW5zIGEgInNlbnRpbmVsIiBtZW1iZXIgd2hpY2ggaXMgYW4gaW50ZW50aW9uYWxseSB6ZXJvLXNp
emVkDQpmbGV4aWJsZSBtZW1iZXIuDQoNCkluIHRoaXMgY2FzZSwgdGhlIG1lbWJlciBpcyBrbm93
biB0byBiZSB6ZXJvIHNpemVkIGFuZCBkYXRhIGlzIG5vdA0KZGlyZWN0bHkgYWNjZXNzZWQuDQoN
ClRoaXMgcmVzdWx0cyBpbiB0aGUgYXJyYXkgb2YgdHR5X3BvcnQgYmVpbmcgY29uc2lkZXJlZCAi
ZmxleGlibGUiIGFuZA0KdGh1cyB3ZSByZXBvcnQgdGhpcyB3YXJuaW5nLg0KDQpUaGlzIHNlZW1z
IGxpa2UgYSB3cm9uZyBhcHByb2FjaCwgb3IgYXQgbGVhc3Qgd2Ugb3VnaHQgdG8gaGF2ZSBhIG1l
dGhvZA0Kb2YgbWFya2luZyBzdWNoIGludGVudGlvbmFsIHVzZXMuDQoNClRoZXJlJ3Mgbm8gb3Ro
ZXIgd2FybmluZywgKGkuZS4gd2UgZG9uJ3QgZ2V0IGEgd2FybmluZyBhYm91dCBlbWJlZGRpbmcg
YQ0KZmxleGlibGUgc3RydWN0dXJlIGludG8gYW5vdGhlciBzdHJ1Y3R1cmUgZGVzcGl0ZSB0aGlz
IGxpa2VseSBiZWluZyBhDQpidWcgaW4gbm9ybWFsIGZsb3dzKS4NCg0KRm9yIG5vdyBJIGNhbiB3
b3JrIGFyb3VuZCBpdCBieSBkaXNhYmxpbmcgdGhlIHdhcm5pbmcuLi4gYnV0IEkgdGhpbmsgdGhl
DQpiZWhhdmlvciBoZXJlIG91Z2h0IHRvIGJlIGltcHJvdmVkLg0KDQpJIHRoaW5rIHRoZSBmb2xs
b3dpbmcgYmVoYXZpb3IgaXMgd2hhdCBpIHdvdWxkIGNvbnNpZGVyIGlkZWFsOg0KDQphKSBjb3Vu
dCB0aGUgc3RydWN0dXJlIGFzIGZsZXhpYmxlIG9ubHkgaWYgdGhlIGxhc3QgbWVtYmVyIGlzIGZs
ZXhpYmxlDQpiKSBwcm9kdWNlIGEgd2FybmluZyBvbiBlbWJlZGRpbmcgYSBmbGV4aWJsZSBzdHJ1
Y3R1cmUgb3IgZWxlbWVudA0KYW55d2hlcmUgdGhhdCBpcyBub3QgdGhlIGxhc3QgcG9zaXRpb24s
IHVubGVzcw0KYykgc29tZSBhdHRyaWJ1dGUgb3Igb3RoZXIgbWFya2VyIHdoaWNoIGxldHMgdXMg
aW5kaWNhdGUgdGhhdCBpdHMga25vd24NCmJlaGF2aW9yIGFuZCBpcyBzYWZlbHkgaGFuZGxlZC4N
Cg0KVGhhbmtzLA0KSmFrZQ0K
