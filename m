Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795553972;
	b=tBYrnUlB7aLWCrEsmoaiDswYZMOW9zcZgqNn0hzN6beCeqyKFBK7NiPsTdDliqzoybVH
	 hkeXHe7qQxKJvuXwcBhwoRxYBT5IalfKHgwI818BtoYPpakPDDwF2Pc2uBloeF7aseH0Q
	 DgWKedjFUvYWBR/91Z32PTPV0chuGwjOLA/B1ltDtopt8P8TGMZ/aMboorCQqrkWdvTWs
	 iZ3IydfA/4CtzvXxM+WXWVa/vDM0N8gOPycxln54XHJuuRVGu1pXH1bTDlJNQH12f4mFH
	 1ushDVCyzKGjD9DlMKUZtNoLryEfdDXCkezkjy3rE6AQHWLqugY28vWtP7H3Cr96f2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553972;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=baLgjYF8vkCZ2TR5W/xiToug9KyQA3hq04nAH0LQAcw=;
	b=fNPQvMA0amEBgs6zipBXNHK3UHdDLdk2JVnl+3OO0nAAXQ645yFM2V2GN1opJZWz2FNt
	 fsKpHYzEO4UNDc3ueQ2Ydn5Ns+uF9cPhQsN9KcujXMXYkF9tdYOxBogdM3vrXMJlJaNzs
	 UYYczIs6ISPwY+1DlJBjYdaHGVIKOE4ezIRerN6DgpzM9chWSpnV62ZbxlIGTo676bf21
	 Rl0s7P4vEcXN/C9ubigwbhh2SQVn65EVzV1aQnMcpv/+xYjOf/MFbUzkM6NyHCnEBPfI1
	 tqWRVIJ5EoKRMSibA2qxjOGvdLduj7/OrmK2QUtpG8yP1Rrk8vUIX3ZKfSPGsFL3l5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ehM0JP7t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.70
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D40606A31E;
	Tue, 24 Nov 2026 20:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D40606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ehM0JP7t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkSGwkd4fsrn1F4BiIE0hhMtl2XFAztWzhvesLLlymY3s8zdlXecE/aTa56UnGw96NmVg6DWEOgOwtzxpAYq56kExM6UvIerUh53jz1NNVT1QH84516mj65YMXMpj5D+Eqauob3sY3vKTN/it9Mfej73zyo9nfxH22nA5MqpRMdONd4J6DbrjcS6rqqHNTOd3fwskwzjzlDgclifQwvsMLBm66Qd4u+91UPBtRA+vt7iGMaoaJs+vrar/3M3q69wXduvhorL0hf/sQfkMYDf6oelpMrwMVCpmQ808Jfo8YZ2hVWtFBe3mD8K6jsf7IJbTNDkwtuvt5UV9noUbEge9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baLgjYF8vkCZ2TR5W/xiToug9KyQA3hq04nAH0LQAcw=;
 b=yiLNX0o/xNqKOEhPDg6i5YZ85aI2c4N8qq0h0fngEJxSxvF0DaP5yhyv88dKGA3C2s4pGuX7IBCK4ZiBaulOLTIiEcFukrnh8vcMFuOOGUUs8yU5z+u/CsnCymN4jHPfWdAzI+5JDfIvJIangwdHdH/R6e1VKp+6W4lToGcs4lzkKjTtLgHZL7NZ8u/VqYtD8pxPxq5DdgFzXusmB8cqkVvFc/5Rgaj6hwDVI6hf64W7texFmNH4LQCTvWoNAfShsz52qbt8qE0ucN1AhfjnAJXr65Y6wBG+uw653ELSWgFN9FeYevu113xEvD0Qoaer3QX17j/j0r7WyfVGSoR44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baLgjYF8vkCZ2TR5W/xiToug9KyQA3hq04nAH0LQAcw=;
 b=ehM0JP7tcUM2Zpo/FhmG/JwOwJUtzU0QhV6tXF4Bh8lNccQuxy8DbmJ/k8wMD3CC80kpmxwFVc9Ha/BkEt6jm0XcS7c7yEuX9ty2X2rvskayOJsFZDWh3HzzFpGWb4T0WRglxZceneWqJBz5gVxcmmj+6wpytv0YNnnsVmc7cbZBsvHFihJVyrv0T2DHORXgXXPsn0At9h1nhWB5O3Va5C/6IRyTrsSgXb3Gc7lBuY3N3rxBf7U+by3240z0bPgQmD+fUwohDqwh3Ie3CzqcKPAkCxBO2KMb9zgHVN70sv1gvk4vRPtQJjRdoYqcz7aH8eGcxqvFuUaZxDQdjqXO+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 20:57:27 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:57:27 +0000
Date: Tue, 24 Nov 2026 15:57:25 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <awXABlb61Bq3NKID@yury>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
 <av9kOeZtIjOtH2yp@ashevche-desk.local>
 <av9ofhBTAcMJud_-@yury>
 <awAH8F_UXdcftgV6@ashevche-desk.local>
 <awBcWKvDGV8sLcGu@yury>
 <awVVRTuvDLLVmRlS@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awVVRTuvDLLVmRlS@ashevche-desk.local>
X-ClientProxiedBy: BN9PR03CA0905.namprd03.prod.outlook.com
 (2603:10b6:408:107::10) To SN6PR12MB2814.namprd12.prod.outlook.com
 (2603:10b6:805:72::33)
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 74dc0538-2eb8-4fcf-3afe-08df4a6d8c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|376014|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006|261021135927099003|261102123227099003|10067099003|261022105027099003|261026121527099003|261021121427099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	IbB41wzPSr/jgeFIUsjkLpwoSOTNfMFYpSDW15eJxs5XBUU9o9MWSqd/E+QBO0fqPlKKBOgdzk4BtqVTkjgZ7P5lxPPIU532hZ8kZfolb0/0hDeJywkKo9cSvkOSlThoHnB/HVBWLQ30uY/PkxgZngyFXL3T61l8y4p3P2Q4KzE3UgUVeQZKTUIlIR8335zgxdI+i15Jh+G0fgLNoGmOl5/qKn0A9eNjnngBhiFnoxdBVSsbvq29wk9ZfhwHNajbXu07sr0P8qfJN2VDASaUnQMA5EZ4Wjv70OrJnoKKAuZRT75pJUO6o/7ONHSqrWAIxPCvHNsCVV/ddYyIMXkuBGmvdb5a0X0KaO/4HP6df0tvLO/ibG3dXZBQXyVJ3qIucaboGOZNuk8RWJKi5iNFbV9RaVPSUqnzxXqy01uVbVQFAOV3nkN6M8EyH5XGk9Jr/ZrXSlVtlZtZNY83oko9IynBWrJPPJ2bOrF9zUbqfe0UY1CmlAyMt1+QYni7TLwb45lNKM4O2TQw0+3KP1P/hD5HpHccRP6piykRYLdbLiOpWFy9/05EjZXftIygW6i1G5JijkE+xaOJShtvenvBalHFXxo/1O0ukz43bT1ApDEaKwyvwWAfkLZql82VwKv/ijp3aRvs2pLWs/YqWq9TDWNRvDqr87iNKAkiMSVYOP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006)(261021135927099003)(261102123227099003)(10067099003)(261022105027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TmkSOTBKDExD6OZVaLrD5AulbxoTrkds+nbgw9d7r2an6ktBzrxwVN6Ho++R?=
 =?us-ascii?Q?RdzV+PV8EDMq+yHF4eRZbStDISODOkgu/L6xTHoGqnmbMua0i7czEXm1ppbV?=
 =?us-ascii?Q?SZtG/tS+ij+smw3B5Sa8g72KXp+PcjI5CLW9aGtjY77vOvkYSVVKCWt6Fphg?=
 =?us-ascii?Q?YAKKMLq5CGruTb3yOR9AMxrnBUOCmRHCt4GDCGZHmbWDdQJJ7fi+SRgUtHbG?=
 =?us-ascii?Q?XjO1VGjcS2gEyAozKqAwcl8OIxFxvC3+UtQ+A5h1asDDyocB5cPN5l73ccsm?=
 =?us-ascii?Q?Tp5ellW0Fft2AD0g09z7XlQ00gCpAL1bMwAuHmnLm1axic1D1sT+L2kkGxau?=
 =?us-ascii?Q?jEFkIGEtGRkBArRKkyvPuwh1QnOqRffToI7V3+uUR2K3YXFYFBpZgKhRktyG?=
 =?us-ascii?Q?4c8tpyUN+D+ViexkkP7O0uRKletKQGuRM8DgjHhlWS0kiYU64vs3znQ1mNvh?=
 =?us-ascii?Q?zoHjL8dAPsSCao6QZZ5r3VLKpNHTSnxZAcmIrP9vrU+Ws63hm63W9HQhFrM5?=
 =?us-ascii?Q?DwoWbXgaNdMPT2uBmJo3Ub/50xMuP3rAO75hpelmFp4qdPL8YAw0lN0Nt7/m?=
 =?us-ascii?Q?aks1LhOp/EKJ5f8edIS8NYUDjIskqLoTs+t+CccOG6iW2nIQeC7IugDeUQ+L?=
 =?us-ascii?Q?9xlRQ6qrzwxIs9XA/crk9nw3pHuuEfIL/fdANN1yJy//M7RVrm9XjYR98/G2?=
 =?us-ascii?Q?VRPeUeD3sT8f9L9VpmE/yEULE5ONGjOP1alV6v26JFQ2ZaReZEmoqLTuaVgB?=
 =?us-ascii?Q?8JmUONjk6is50kmN0Calab44uJAAdihpXGnS6hH2A1Pow7hDGpPi7pELz20C?=
 =?us-ascii?Q?/9lFxY7ZAIZ0jG5pH8fbdC0axQ1+AUGRgWFAFNpznVwfdZb1Heav0I9DFUxs?=
 =?us-ascii?Q?snFgSArU4/mP11k+JfEZ4Y/duyVK2o14obdjMlmCN+uTw7NReTWd13wePwcW?=
 =?us-ascii?Q?kfHeVb5/0g+stDNm8cA3aJB25SmY5MTK3skOIMBnbm5n7aEqEZtLaNUk1MKl?=
 =?us-ascii?Q?7nMVBYqAr3cIIjsxsrodJV2JT1Q9njt/NDT0XQncALUa85MMDX/W0F9DNYBj?=
 =?us-ascii?Q?DKI/5yunSmrXKPBy893lXx4alRH8Jo8GsuoyV/0nYuo4SEk5HY0Yjcdpvg7L?=
 =?us-ascii?Q?zQWvidjquXJAxZqrFE+p/05kkpuHX0Fthx3OcWGk/+nE31900IWfm06ujUi3?=
 =?us-ascii?Q?rrVdhVISDQ3DFIY2Hiffkeh+yniaHwgNWMONatHPy9Ubyckn2PxtT0RFB+rE?=
 =?us-ascii?Q?j2HRhEUTl4khv//k8n+RR6x84i6I/hdhxfZv1woKS0kUC/XuAxgn1H/uBy75?=
 =?us-ascii?Q?5a0L+LFrTPgSR61digawxHVwVzTkF8iBZDR2L0b9T8oYdoy53tDDOoj2eIbB?=
 =?us-ascii?Q?dm6c/24YMT83mCQ3vvUcPZJFbQgW+1rLV86LSeYOaM9epmRGlHZFalaRoOzd?=
 =?us-ascii?Q?n8oRjjLvhB9HT9x+tzI+vCqlvTgI/YNQB3XpnAqki5VZCmmcg8Pd9Nc7r906?=
 =?us-ascii?Q?DbI0UIBfK4rDUGHJV73o6Fsc+5/qb36tycR2wWjm66ZmENB5NPcSgVw1iVS4?=
 =?us-ascii?Q?7ReNQkW3Y1cm/L1j4SwDvxJPsTdxxiqmUmwkKEkKbJI92i1btmBKd33AAZR2?=
 =?us-ascii?Q?5WgXfbkS7DWt8FVxsJFUruO35DCBwHam96Eio1vXCVqzz+EIb6Oyry9DYDwh?=
 =?us-ascii?Q?t474Bybai0nkAqteJOLdzo1YmMpht0OiLcKDeRo2SKd4y4BhxHuRDIWoLR7S?=
 =?us-ascii?Q?vz54tHY4HRdX7dzGpm9PzXp3HzzZzwar3vswUGVd2dQm+amn7spJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dc0538-2eb8-4fcf-3afe-08df4a6d8c3e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:57:27.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqPlCW0iSUBvPDAAqAcHumFfLG7JTwu4KYUjaRkkNwuKNaOXS0HuUnSR5f4Ds3nE+2hlnh0/GDHw0zak2hgnYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

On Tue, Nov 24, 2026 at 11:13:41AM +0200, Andy Shevchenko wrote:
> On Fri, Nov 20, 2026 at 09:42:32AM -0500, Yury Norov wrote:
> > On Fri, Nov 20, 2026 at 10:42:24AM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 19, 2026 at 04:22:06PM -0500, Yury Norov wrote:
> > > > On Thu, Nov 19, 2026 at 11:03:53PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Nov 19, 2026 at 03:37:33PM -0500, Yury Norov wrote:
> > > > > > On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > I guess... Let's keep the patch minimal?
> > > > > > 
> > > > > > > -	mask = BITMAP_LAST_WORD_MASK(nbits);
> > > > > > > -	value &= mask;
> > > > > > > -	offset = start % BITS_PER_LONG;
> > > > > > > -	space = BITS_PER_LONG - offset;
> > > > > > > -	fit = space >= nbits;
> > > > > > 
> > > > > > I don't like this 'fit' thing, and would like to drop it. But
> > > > > > let's find a better motivation to do that?
> > > > > 
> > > > > Why? The fit keeps the check I want to refactor, since it makes it twice
> > > > > the code with that ternary looks ugly and unreadable. This is exactly the
> > > > > chance to kill two birds with one stone.
> > > > 
> > > > That's what I meant regarding the motivational part and minimizing the
> > > > patch.
> > > 
> > > OK. So refactoring bitmap_write() to make it look like bitmap_read() can be
> > > done after your nice below patch.
> > 
> > Sure, I'll take the patch with the tags suggested.
> 
> In the Linux Next it uses Link instead of Closes. Perhaps you still have
> a chance to amend that?

It's not a fix, nothing to close.

The patch is not about comforting sparse. Mentioning it in the commit
log is there to *highlight* the problem to sparse people, not to 'fix'
the kernel against that false positive report.
