Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6F2119
	for <linux-sparse@vger.kernel.org>; Wed,  9 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508717; cv=fail; b=dwd3UIL9U4DywSOsULGRTbYUrFFdAySq0Z2CW5sNWvf0DdFj1LpalWcSPgQWIm8u256nSLGdFRcXHCnP00cm+eWF7iR7dWaDkDFAU06wrUQiy2QdZCwmCg4Ul68q7e6BwFGGJxPQqY/fdiG0556N3LgFykfRWyS25o6n5NbkUSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508717; c=relaxed/simple;
	bh=BV6T43YzNVmpvD1224nSIT1ehQZOYNYazpVZk3ZTdDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVUiKgNFwTrFMfORcxpRo0eUANZ9kWkm7o3bfc7is+8csJNc1EeH9t0sbTOvEgvEs3pk7qvjezGxhGZtbo0Aw0ypLadofijNF5cOfG1EHrIGsC7zI96i3h3h2MgOxvzgQ/BIm3QFSqi6Is2lkmofTC8Bmzb5UMo8IyrZL80+tlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/7HJ0ku; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/7HJ0ku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728508715; x=1760044715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BV6T43YzNVmpvD1224nSIT1ehQZOYNYazpVZk3ZTdDU=;
  b=j/7HJ0kue9VNxFtsuALWUjJ5Jp9tfNIySSALMsU/5670aPSnFi+3Ef2T
   tT3bPfuJR2+Rctjd961h8CD9P6hO20QN0ki1lAg9MGjPfZTxRtDHEISzh
   uzusaFNZrMyGeYSNl2xokAaQfEmPjumaF6KppavSfyXGL/qXYx0mrNe2G
   A0FAqMl75zoSFv+suL3qy6O4JnAbhcxawKLWabfUwuwJKJ6NsiN1alpNm
   ZqksRuDfbrGDmIgxzAoV/ZTtd1e4d6EqghPTXt+9gWM60eyBhwsSdM7MH
   qSnQ7aqSMAkA/37LTc03qVvmPlSsQ0YkRlyu8263Hxi5DRZZsPK1oVvuA
   g==;
X-CSE-ConnectionGUID: QQARdPEDSsmUHSJsxTis/Q==
X-CSE-MsgGUID: 3zfeSpnlRa2MaJVjoX4y7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27969206"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27969206"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 14:18:34 -0700
X-CSE-ConnectionGUID: j6m9zs30SWueTZscscrsAg==
X-CSE-MsgGUID: bNv+iSKrSbeKCP2sm5LnSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="113855385"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 14:18:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 14:18:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 14:18:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 14:18:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 14:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8rg9c8WXq3cyywyvW0VI1+vzG+6AWwnb9zTBC5+U46+RIe5dwhGuQ1QMEmAdaYbciSX4zzbkhD1kRYv3kAxzk+9oPLxlZnD0iOyqNLmQdMGWbKf5q80j0aESNhGINT68kwNmIzBGUZtkDoAPALK6ElO1QWxSf0E93LUFhFLDNJhriN+J29CExGgb8psSaisGUvfkemltnwLZeGiPksQIeQtK8127UQ5vZlQxqcZFwGFh8lG2jYpAkL0OQUOxXkdzhXlN6FNfFJPqfYnub6ACAYqZqfKnmRj1YiGGoSZGdRVJcQqepb6N4CAGj3Ipk6fCjOMJdC+Ac/D0w8D+kBuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFfXoIcr6b8VhoNf62Dt9r/SkpKLbhV9LZaGClPZ8kw=;
 b=lxgNOwo/y66BBanpwIAGzOuFj4zV1ErQF3+27f6LrM+DoxuWRFHSaMtNtHEk3UlOP/ixLOhcWS1CGQeSHssoSqkh4opH2/Q8BNYQzxkhrk8a6l+KDl9MXGgWSJYXoT2bv49BAE+bK5f3hjwzhYwvsFmv/tSvl8fpJHZvxiWC4tuRbPwQkiGIf2ZY7F3CqzzVl9VA0RPPEUl9qTs+87BQogWPwpGJ27VKU/PWwTwuTdz2m9Nm1Dfof7lB2g5vpfp4dy0hnrkJ22rPiaqPFlyS69mEaODGm5j9/Cl1xrGAP+iBZcbMUrUW57WmpR0L0J7sSzqo2IYiYuDuycGIbaNApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5869.namprd11.prod.outlook.com (2603:10b6:303:168::9)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 21:18:24 +0000
Received: from MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::b7d6:232d:eb8e:543f]) by MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::b7d6:232d:eb8e:543f%7]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 21:18:24 +0000
From: "Herbert, Marc" <marc.herbert@intel.com>
To: Luc Van Oostenryck <lucvoo@kernel.org>
CC: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: Re: Christmas wish list: -Werror and -Wno-warn-about-X
Thread-Topic: Christmas wish list: -Werror and -Wno-warn-about-X
Thread-Index: AQHaSyyZaUApuFSDuEynX+4xxOUUIrDh6UKAgZ6h6IA=
Date: Wed, 9 Oct 2024 21:18:24 +0000
Message-ID: <DC94BE6E-41B2-45BA-A7D3-B8F19D535643@intel.com>
References: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
 <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>
 <xwsuvxor4dwmmabaf3f7acgo53rkjigtzxqfgdmlibkgejb2m3@ib6s5sn5njgv>
 <4EB87136-D1B0-41CF-B552-9E9F19C00F3B@intel.com>
 <hgs2cgb2auv5y3apocuig6xjhmv3oy5hbzmvjxrxoharjb3fzy@mhjaitwlrnvy>
 <28F15CC0-6BCF-411C-8481-9EC8900B8372@intel.com>
 <3eifvstptigzcjthdjwshxxxqtn3yjtm4jifhs4sqcsrqhozjh@6ixifzmsekkq>
In-Reply-To: <3eifvstptigzcjthdjwshxxxqtn3yjtm4jifhs4sqcsrqhozjh@6ixifzmsekkq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5869:EE_|PH0PR11MB5832:EE_
x-ms-office365-filtering-correlation-id: c8b40a6f-4758-4047-d4cf-08dce8a7e8fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5CsOAWEW7yTP8KWg6C6/z0P3ZVvS+LNVHTBfDtSq6YlAsVzuijYvRs3H5MQ5?=
 =?us-ascii?Q?4GmGh5P/vXihML9lrnwzlJ+t+m2aKHAvEMoe82FHgmh0BKke1MpP/oJvLBpq?=
 =?us-ascii?Q?RgSztBifM0wjcAIIP8DTQ7x8nxSzjvqCWKColn6yuPNMgG4+25iT5wVR344i?=
 =?us-ascii?Q?VSDA21egQZojuwpAxvL3BpcOm6LDeMA1HMjg227GYaRQECFcEF2JUQWBgYTU?=
 =?us-ascii?Q?88CN8DCejALsXTy/SVzq7EdHvGzMkXPIzFVQmsWFsO1p7l4+FNr7DYGhBQU8?=
 =?us-ascii?Q?+FPx9syp5SBFWmQaRBPSPpgnRXMJIkY3dAHEBFpd+azpNLKdSWWhk78uqYny?=
 =?us-ascii?Q?oP+huA8rFyoCZAhCLe/P0LpW3BnXJku4ai0vOKNWXQUXAOzeHVdAYlVl1K9y?=
 =?us-ascii?Q?LmYs4t38i8ZjhxRZI2aTzYORcXZqFybaUfe4bIY0V8/LWqcpd7hj6gYLB870?=
 =?us-ascii?Q?qNJ3gecBIXWxwh3taUUOIiWpW4LagnyjANPkJ1lnA+GnFLbQAP1E5oxd+uqH?=
 =?us-ascii?Q?mc3pTXpzsaztVPlEMGN3rhdFDMs4RPLphqBAv5AgRMOF7qs8hUDMwUoNJjia?=
 =?us-ascii?Q?MPlzvv9CVk+jToru+4xv0UZVS3etpJDUUnfKeMQbCXVAWNtSe8OTjkYA17za?=
 =?us-ascii?Q?RUWZbrFAcyAOtfn0UHCeNalE+VJl7t68hR3LYB7i8nXcb1ANSyFYoQ8EG7ir?=
 =?us-ascii?Q?bd5F5ZraZG13Dc8cLs6/Yw83V/LAGUoiY25sR5NCDCoAGLk/XP2YKw4L7RoH?=
 =?us-ascii?Q?xIsu5byzAb2l0PgO47bNhjAD4ibqU8Y9Wsui2IS+k0gBSpE1NCww8+sz65h0?=
 =?us-ascii?Q?bLd1vgsL469udSupHslt9gUIzsIDm93QEHUG/xyngmpY6jSTPVHZ3R10S5Ui?=
 =?us-ascii?Q?blzpr8imtQLul+JQSUDKsgs2QwQmcAi7Hlfr1DSV+SnOW0g6SWEX54TzX56g?=
 =?us-ascii?Q?fzh+DXDWMBnmIkATaLTot/lN7M81bRj6XlckROxTIEyCdlcQzIg2Ph8V3UA2?=
 =?us-ascii?Q?or6JsHqcG7JeqAxzeD038WMLvPf3gulHPyQUoovRzum1Rh53kXhloM4YmY2C?=
 =?us-ascii?Q?IATclijkAPGL3cFPKRD3MRN2fNBDJuLloDAeebAkrEhNBHN+jik4byCJSmeX?=
 =?us-ascii?Q?P0L9v97HRNR4fAhmE0tgU7vglaTIRjzj3VhGIWDQmPVv4/Z8drlT4twQD8Jh?=
 =?us-ascii?Q?pTvW/j9rvUUggnv0gt25miJqlJdjxtrvybSgxxw/K89JVwiLMOT0LwbIzC19?=
 =?us-ascii?Q?GSt/K29tZDP73XCd3GWnHTdhGGI8NoOCsHAruH/BsaPRgTGxsYKMwieJ4zFS?=
 =?us-ascii?Q?KYE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QjRwvrCQUkNeKmIZcrzgItMsB7FsqymO3QZ18rlcW7eGQFqqG/J/Onp8iVsx?=
 =?us-ascii?Q?hjsY5pg4LLv0LS0RwPSrDtduse7bQtxVTZzc1b1eNegA/0WT19gPG7QMV0nM?=
 =?us-ascii?Q?n9cf9J956WNTuEbK2mDSGcR5PunNtt+Fk6bz8+VrVQrj/vgWBh63IzFtC9du?=
 =?us-ascii?Q?VywqcxthNztkrPFxrPHmL614aFG6WmEQ8+37KDOugA23Frdb3zjg4Q86hW4U?=
 =?us-ascii?Q?O7eHiEj04SLl7kOue+sYU/sFy1NFIDzb4KWB0xAVA5UU+ee7gk07ZTqheTCc?=
 =?us-ascii?Q?zO+j9jOi3KYF3naAACwe5YWc9pPBAddDrf++VFSomdfjCPyDcJSsXEwy3izJ?=
 =?us-ascii?Q?j4exddEGeTifxlgS9kcb87dkEjW5aFbHcoAZ+mbVwRnRvE49uDlovq8jhGN7?=
 =?us-ascii?Q?8cCCIkmkfSuDdB3HZMM3xOC8W1xWlZgkq/IM51qD2rWZSdzbCCdPHoOvAYDi?=
 =?us-ascii?Q?jFuhnXRcdUHufc2ypTK9ElLGxTWQU7MCUKLB0ZFtKq8TyXLpgUxuZt+VXoRk?=
 =?us-ascii?Q?7JDgNyY1o3houJuSgY5dEFAoHVkzY7uodzYDD4ZfXngfzPqQqgMNE389K8eL?=
 =?us-ascii?Q?WdZuTPIrjH/GgiTank+62BXYLFSc5hwYUxVXt/LBo+r/kiza+LEA+OtwlU5f?=
 =?us-ascii?Q?paXYkv0ANRjmjA7K/0LkG8XB5pjpDvHuHvYvb/NBjGAGy5vtFjkOKDKsIwEy?=
 =?us-ascii?Q?/mLla+o7+sbHmfyZp4uulgXsz5nYhvZZMXSkaoR8uhXPj+c2XnxIx6EZdbmB?=
 =?us-ascii?Q?1OUFDsXs6oY+L/BM4bfxxRePaokl+SZbKW+txF+dbUlRZTgYsxxbKTc/pUE+?=
 =?us-ascii?Q?TWr7srCli04tKqvSt113LCfbiu35+9JYZdNZzxq7T4W+c7UglmeoVLqoY+BQ?=
 =?us-ascii?Q?RemIzswdXUQp4HDVJlzwJ/BCMcXvuQ5U5mBzzoBGCLUI0cMUw7gOSSrY9Wdc?=
 =?us-ascii?Q?G6JaGgKjw05X3/CjDbzaogIwTteSiEX1VhbdLWRDTj56KoFOkEwlIDbVejVQ?=
 =?us-ascii?Q?mRcYEXp3Ah6oturBZXRDrM8jMXV0cPM14wmltr9QrnJIJWSIakSGi0cEwL5n?=
 =?us-ascii?Q?9Vpj1ICR7fMm3fhrfg2vuS4srLy1nwnUOvlfz39eS8v5QTdacQ5aYhMTqmAc?=
 =?us-ascii?Q?s//uzAZeVVfXZM6zy61fUy9RkTh2sPY8uguWDXYxhLibXAFE6ZWHtTtmLGcX?=
 =?us-ascii?Q?fVFpD/teoeNEOF3BcGVrhg7M4Vk6SZbQaVIIRZYxUPAMljYz+IhVc90huTF8?=
 =?us-ascii?Q?gdVx8cntL9q87h9GAfa3Z9owPSXbQjpBMgSl8C27GuzVjTX5M5o5REf+h2kX?=
 =?us-ascii?Q?wI+1H4D4KU+mCVU9FuA4VhC9xMJBftxPHbJHwxCKWQtVZCtuOU2jRqp+B10f?=
 =?us-ascii?Q?3Esc/ufkQxSSO+CGlRWdeJNde73n45MrH7PXRoj/CsYidr74v1XnNfVAiN3g?=
 =?us-ascii?Q?oZ54fpfYX/OgalJb4wyYjNaoW2uCh0WexUCFLcq29ZCXYK0vEXTgQbeKruQV?=
 =?us-ascii?Q?xx6MogUIuc/59Q/fX0P9ERRyJwOnrKTKqrigbtRDVCXKjoQ95PSynIjahVyy?=
 =?us-ascii?Q?svil/mO+Wk+3gpsLidVBzN2AFuhCmFOuVFEIQuvPnaUobqqN1WZk1kyuXAmT?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AB5C8E013E08643A39390F70F02E3A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b40a6f-4758-4047-d4cf-08dce8a7e8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 21:18:24.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pR4jUTUJnv/0wefILWozw76ov7fD9SHdUgTdX7S9I47XkWWuo3uoEsJsF2uGaCa5aMmK5C2OOCL0qUGNX8lUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com

I just realized I never answered this? Sorry.

Adding a couple people in Bcc:, full thread is here:
https://lore.kernel.org/linux-sparse/3eifvstptigzcjthdjwshxxxqtn3yjtm4jifhs=
4sqcsrqhozjh@6ixifzmsekkq/


> On 19 Jan 2024, at 17:27, Luc Van Oostenryck <lucvoo@kernel.org> wrote:
>=20
> As far as I understand it, -Werror has been replaced by -Wsparse-error in
> 2014 because sparse was mainly used with exactly the same options as the
> ones used for the compiler (which is good), there was too much error
> messages and people didn't want to have their build to fail (see commits
> 4d8811879a1c & fe57afa0b44a). So, essentially the exact opposite of what
> you would like :(
>=20
> -Wsparse-error is really a pain because it also turn every warning into
> an error (and then exit on these errors).
>=20
> It should indeed be possible to have an exit(1) on errors but I'm very wa=
ry
> of changing the current behaviour. What about something like -ffail-on-er=
ror?


I'm not sure how the ideal user interface should look like but I know
what it should _provide_. It should be possible to make this decision
for each error type/check individually:

- silence
- warning, exit 0
- error, exit !0

gcc does achieve this. It's a bit awkard and probably not the best user
interface but consistency and familiarity is key so why not the same UI
for sparse?
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

So this is one way CI has been successfully handling gcc warnings:

- First, define the subset of "forbidden" warnings in your project.

- Craft the corresponding -Wall + -Wno-warn-something command line.

- Hardcode that list in the project build configuration.

- Provide come EXTRA_CFLAGS=3D parameter for local/temporary
  fine-tuning/experimentation.

- Do NOT hardcode -Werror not to inconvenience developers. Obviously,
  sometimes you want to run tests on code with warnings.

- Do hardcode EXTRA_CFLAGS=3D-Werror in CI

And that's it, grep-free!

If you need even more flexibility, use -W[no-]error=3Dsome-warning




>> So far we've been using a brittle script that captures the incredibly
>> verbose and mostly unusable output (mostly due to some hard-to-fix
>> warnings located in common .h files) and "post-processes" it
>> with... "grep".
>> https://github.com/thesofproject/sof/commit/b7708182fbe5d
>>=20
>> I'm curious how people typically automate runnning sparse on the
>> Linux kernel. Does everyone "greps" logs too? Or is it more like
>> `$(wc -l) =3D=3D 0`?
>=20
> I think so (but I could be very wrong). An exit on error is only useful
> if the output is clean and the errors not too frequent. I think it's
> often not the case.

This is a problem only with parallel builds that have mostly unreadable
output anyway not matter what. Here's a dead-simple and very robust
workaround that I have successfully used a lot in CI:

   make -j || make -j1

Ta-da: now the _error_ that stopped the build is last, _after_ all the
warnings that did not.

> But, if your main problem is with error messages concerning address space=
s,
> have you tried to simply use -Wno-address-space?

Funny you say that because address spaces is the one thing we care about
the most and why we started using sparse :-D It's the only thing
we "grep" for failures:

https://github.com/thesofproject/sof/blob/d345c56e71b495a1e4eec1a48e48d3d5b=
e055cda/scripts/parse_sparse_output.sh=20

But I get your point: "someone" should probably look at what -Wno-stuff
options sparse has available.

Also note: some warnings point at "real" issues and if you silence them
then they will never get fixed :-)

As a coincidence, this sign warning was just fixed after 2 years:
https://github.com/zephyrproject-rtos/zephyr/issues/53505
It was especially verbose (half the total!) because located in a .h file.


> Some other error messages issued by sparse can't be disabled but most of =
these
> are, I think, parsing or typing errors that are more or less unrecoverabl=
e.

Yes: failing on unrecoverable errors is good :-)


> Purely for my own curiosity, could you send me one of your log of sparse
> errors?

Running daily there:
https://github.com/thesofproject/sof/actions/workflows/daily-tests.yml=20

-> Sparse Zephyr -> zephyr-sparse-analyzer / warnings-subset=20
https://github.com/thesofproject/sof/actions/runs/11206675653/job/311477703=
59

Corresponding script is here:=20
https://github.com/thesofproject/sof/commit/0061953a595b18c12a5962edced12d9=
ac9ac1ce2

Take care

Marc=
