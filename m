Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795185760;
	b=gPplAO4eSkS3+NiFHw+HXvfz4jnSlQLztbF3t8yv9qjZqWDYT9T+bK+gUn926K8Y0esL
	 HWrANqgGINH5USMw1txKNZvMFfkhDPgsHxRJOGPvtLxdyaw6fSxWYbt80nK03ofWTYptN
	 mUcbe/nFiz3CIl6EyPG4MBgS7WKoTcMBNhlm7YPDfYwHDK06AtiJaF29z3j3fFD1S0E2t
	 sJpnhXxrpAaW5r0gvy790Kg0K+Z5Ggd3EOOIQ7x1+H1YFcYwR9U2MwrlfVUlrUxn3TZN2
	 Y0qlJyGmMTnswL9bNwo70ofCEcu+fsUcTX7puu4mXAXpYdsHLHoB5HiMH0GBnfKh+Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185760;
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
	bh=KslPrTyQ+ilHIdoRB07ETXHZTBjDTn47cIbMXBkoYTU=;
	b=fjOK+g1DQz94PsHrAZ3Tt+yYaBrf7SMoz+yaQtG9sPhLt8MQQFMVCFOiA9jhCTWijdJ2
	 UsKkuUNUkgcuX0FQHGFEgUur7yQoTqSg8PgIXDJ7JiBoWPK978pOPO5YwJAAu2iM4BqGU
	 yO/JvJ9JKUq1GXXpxRU9CArKkR4rTRto0mje5QmkhSAt9VoUoXuGeo+CiXwJAcmoKaOEN
	 YAOJKS620CbStghqQPCrHs+coKybM+77T6+RTGh6PenoDuNfuGGCFFjAy9gkg0ew04izb
	 P+zVPCxQ/TEqmnQloCs/y2loeSd8RXwOX3bP69dcAyTSrqXSpDLYgAMGcC5JicLCSxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LvoYHzix;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.5
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8185606A320;
	Fri, 20 Nov 2026 14:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8185606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LvoYHzix
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8+z5GulQ16k3Zs1IaW7WqxnMhkUMh0VH/inD2K+TGEqfKt79FKes9i1ULSX24aDLhBollg5dN8Jvm6LY9cahi84eQ+WTgcF7i/ayELLllSWq0ao19lSvR85OTStBrRVgv1t1imzox3tBCUCXkf+8lnNFidtwOW4oRl0z+WBEkomWcuFQ7wEnL/bKkTg8tbP8MwbWzq4tJqlylkyb8isOB68MnTK9WJkeYumTISE2OdEA16ztWGdLyAKPrgCyo2LkFGfeZqGv7dkwP0uH3Erx/zOWLv5uzauUwVijQtHXppAJ8Zcj8DROL3Ke3zNsjMP3n9v8tR9FyX4XwGEFMB0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KslPrTyQ+ilHIdoRB07ETXHZTBjDTn47cIbMXBkoYTU=;
 b=ntZSoEXY0U5G+2gC1cF1utjCmJw+Ft/v1ztdLs3zm5MvmnnTawlrlfn2bM7YJaxO+nFOO+aE/b0EAsDoxQ/kXsokX4ONMxWisHDVk2ci8oyzjo9Lwi3T5H6zl7tjqPx0k3NYb88aoF3g5ZwPjYM9KMtydPHunZCfer1YNNlZW3a62+RZyfWHxRoKvRLcqg5hUAoKY+u+BceBDI8UHUXtCZUbSeASHRCjYpuMiVw0RGOoTntTeXF3EuNi4bvZwWjwTvGLjWBi9lGyviLAOtTVGMjilZ7r909DKjXFBWPCjuQV/mmoTLULeTIIRl8Rxnu24fJrPgR9p1N6zElua+bciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KslPrTyQ+ilHIdoRB07ETXHZTBjDTn47cIbMXBkoYTU=;
 b=LvoYHzixURYW92BRODKMct8w5cePdnHlFtex5231acPJ+HrxBj5bThQ4VizsmVWKexz/NmvCXMwTd+WVqJR75A95VFSbgwfX/F/gEHZiPMk8qQ18L7Vy2BNQLpfJBUjGENdWJVHH1iEOyz7C7wIbUaJ+HVWmM0CCpwHxZdO947UZ8R/LuQ36CQqTb/FG7gucCdrLbnuLMTV50NsotHrxdYJqpeCtuvbmEv2AyljWyG4ryzHRhl7p2QNDTOGjSQcgP8hqfWqTvwLzPhHK2w2GEHZpmHLbecXLIsuFnyOjXgWejhQkCqU1VeyQ/7URq+RIPMbvwHQgJjwwZieTqo3YVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA3PR12MB951235.namprd12.prod.outlook.com (2603:10b6:208:709::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 14:42:36 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 14:42:35 +0000
Date: Fri, 20 Nov 2026 09:42:32 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <awBcWKvDGV8sLcGu@yury>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
 <av9kOeZtIjOtH2yp@ashevche-desk.local>
 <av9ofhBTAcMJud_-@yury>
 <awAH8F_UXdcftgV6@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awAH8F_UXdcftgV6@ashevche-desk.local>
X-ClientProxiedBy: BN9PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:408:fb::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA3PR12MB951235:EE_
X-MS-Office365-Filtering-Correlation-Id: a3db0020-9d7f-4520-eefe-08df4714837a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|1800799024|22082099003|18002099003|11063799006|4143699003|261026121527099003|56012099006|10067099003|261021123027099003|261021135927099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	3klucHWmVeiJ57dluzS63BtTeiZquJ00R0XD7xKE9YM230h9rQP0rHTu9zZz38mqFPRRzRkCPQy//gbWeyt/8rvAiCd7k1Ec6ExhWlp6ln9lOM5RGf428wKMPfVVoq+WpBrnwbXSS5a4QTzqref3oH85Hjts6bYGfmdHVXsib71AHVfeLK2HB4eIVH5hsgOs1zqFtYFrjgVz6H54uVZXS8OoSdGfN5IbGkYDPDN6lWG9C+hj4p/TELX9EG8H5iaQw2osHHu52a2VublxAd6suu1RWMsFuJfF55gnjpvxs9lgiNo0pvCETihMEKx0BrI6vLIyoeoLgvmKC/gIC9Mw0kk7qH//nI0rpNcp+CCxt5xCm0J3P6R62E0aegNkXgf18hjLYUX7QuxPolygT5PA0UrkpPs4wp2XDtKhRW5IST1D1ZjuRidrepLs0svP8d2IIyuf6iuAV1hwT9Hfv99B+22A1CzrBtBRaoTG7LQHms0+z/KEHbp+4dK5/dwZj9/hXhHL75FFRv76gfPXwvA8lF5H96RSCKJ+qG3bZzsosRHcpA3mIMeOeR0U2WsXKeH49bIl+Ldf6juNlK2ph+f44Q4eM8faFPcmH/zyvXZUrsd/sQK4vRLYbLrFljnmV3aywK/32CGcgUJt3Sf3UHsnNjj7OKLlvfCs3WCaIcd5uE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(261026121527099003)(56012099006)(10067099003)(261021123027099003)(261021135927099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IeEvXuFhoO9kd4UiT7tX0M7yZSr5RxUzk2MNTz/dS1QQuXYN5KIUekoj8tLy?=
 =?us-ascii?Q?AS1gz2JJJmWHhW4Z0U1l2f7NjDsv2cGT1UM3I41a0uZNrlXe1XrU5rQBRSXL?=
 =?us-ascii?Q?1YJlaz3HkjVINZ/aVg9X6CkWyvS7V1AYTwlG5fvhSCfZmPlon95q7WmpnKiq?=
 =?us-ascii?Q?jFSuUbl+0ejesswsz+wnqtTdnnQHav1jTNliPqk/yNddcI7gd73xneKzPFLg?=
 =?us-ascii?Q?tHHkfbKh2C3v6si2ae6JqUHrhGy/+C1MNoW/t2ZHmQFUTwI3KdPmsTApmUoD?=
 =?us-ascii?Q?lfl4IYExcghAkd/k5A7W1NjyTkw85wa177of2LWt6vlitJqvz07wqhrQOyUc?=
 =?us-ascii?Q?L45EB/baOzQd44Yn2NM3bbZB6z64aYTtHIk570D+559Eo7sWHpYTEKSrnaMC?=
 =?us-ascii?Q?MoZm/QPxYONhMzOptMo/W+X5vCYxje9iH419XDu4PzUahgG09+n3EpvbbJ+K?=
 =?us-ascii?Q?4Unk2oJ3AFwTlDp88nAeVaqOVUM0SfPXtKDzkDZRfr2rLk0iI/XAKvAm6NnI?=
 =?us-ascii?Q?vAgOkTQ0hpIUIF2BS+QaPI3rxVzdl+/B4eb50trZJFeSv1DrSCA4K8ZX8pGE?=
 =?us-ascii?Q?KPNEKSNE60JYoZ5Aj7k1YOChDMjDLEdKUX6h+4Q/9EG6vwwtsXoTUXYA/Wvz?=
 =?us-ascii?Q?Fu7TM6n/CwPx+rt+3fxZlJ2sdxNjiaTM5p3T8mMWK/880+5Av9XIeB/6h9KC?=
 =?us-ascii?Q?HW5oGEkw693EZiYRyLCyO6HGE5DovgsQ3BjAGu0/jqI05IEkbJnVXGR6oRrO?=
 =?us-ascii?Q?qpawPedH+QQkjn5HXMkN2wemvTgTp41AMDqE2d7ikkhUREN0zaO5icD+UU2j?=
 =?us-ascii?Q?KV8kjqvgP0Dl4UqRVuggzHashhcvVWpUQUTieE9LLX6r/BfWPdoU/gSJyWdR?=
 =?us-ascii?Q?ak4OqtHp0mdFjos5/qV7HWrg4+raIBi8j7VaG48fMUqPvf87WBBKGUuIzb5r?=
 =?us-ascii?Q?VQDFKCoWD9YSKxhlnLDoAmAgxhV4EUcALIYJy5rQ9RufO9xXvZKWCphtZ0t3?=
 =?us-ascii?Q?cXxwSmjGmzyOqidua4i0rvW3YdYnR+Jn7CZijbeFtho2RjW7Rxys69uitjBF?=
 =?us-ascii?Q?vE4U0vnRy1jxr4hG7oFIubWwoimN+d2icIYxIN9aIotCjNUVJWXO4DbaE3Uk?=
 =?us-ascii?Q?5R7sYDVTqpp8wB1EXoMzt43q87l53j0R7dFIy8j+21CRhkzFYpBYaqy+T6X6?=
 =?us-ascii?Q?oHg8M5kJ+bSvJfoVvh+Y+zoDjVvlus4Zjyx40H+ZTV2ZU9h3upjTTlXY2Wf5?=
 =?us-ascii?Q?tbVzVfp0PbrzgtpuswoBwgFyL6rXzWYFgbIL4mfCHyDexa/JZk8iVCZyfKFo?=
 =?us-ascii?Q?A48VJXv0buxucxGUIThQXT2LHgnYPdm0vFb2VmyC+77DyQPvBVgx4VK/LoNO?=
 =?us-ascii?Q?4q84BOjmspvamb56TZCwbRpd3PsqiPLpoN0yboGxj81WHXgE7bMxC5VMaBNz?=
 =?us-ascii?Q?BAi7grCiNGycYP/0DJd/rFz2kNqmRtnCCnFXDEttYhJkfjWtXftnqvwv+AcY?=
 =?us-ascii?Q?7/5n055DOb04GmiHEYKrc8S2mhrxW5XQeXCOgnIXgN+Cjd0PJAL7oVLHWzoL?=
 =?us-ascii?Q?gOEPPrI9KOdd3bay1Qjebm3adxiSmeUa/Y6DOJKK/afs4Q3atpSkLL139LIT?=
 =?us-ascii?Q?tMoBr0cU470cQL2nWQR3Sl3RsPlHgDnGuyBuRmCjloXEqbaU96IhhoMxk77Q?=
 =?us-ascii?Q?eEZw1cQJ0iJ3lIYIbqbmudET/kL3fVDv7/q0EmOdfxV1vinJEtk/IfiVVpc4?=
 =?us-ascii?Q?IgIsnhg/BAtwmlwRijftwuBuXliItFX2bckxJCepR/uLCJNpMBWg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3db0020-9d7f-4520-eefe-08df4714837a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:42:34.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrQaB3TPy4sTschvsmrQx2rttB2kF2mDIxs5+pflj4bhFnIMMrMp0XaDvl4jyPxboqlF00gDCL2ohO6Udi8Wbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB951235

On Fri, Nov 20, 2026 at 10:42:24AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 19, 2026 at 04:22:06PM -0500, Yury Norov wrote:
> > On Thu, Nov 19, 2026 at 11:03:53PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 19, 2026 at 03:37:33PM -0500, Yury Norov wrote:
> > > > On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:
> 
> ...
> 
> > > > I guess... Let's keep the patch minimal?
> > > > 
> > > > > -	mask = BITMAP_LAST_WORD_MASK(nbits);
> > > > > -	value &= mask;
> > > > > -	offset = start % BITS_PER_LONG;
> > > > > -	space = BITS_PER_LONG - offset;
> > > > > -	fit = space >= nbits;
> > > > 
> > > > I don't like this 'fit' thing, and would like to drop it. But
> > > > let's find a better motivation to do that?
> > > 
> > > Why? The fit keeps the check I want to refactor, since it makes it twice
> > > the code with that ternary looks ugly and unreadable. This is exactly the
> > > chance to kill two birds with one stone.
> > 
> > That's what I meant regarding the motivational part and minimizing the
> > patch.
> 
> OK. So refactoring bitmap_write() to make it look like bitmap_read() can be
> done after your nice below patch.

Sure, I'll take the patch with the tags suggested. But you're very
welcome to continue optimizing it - my gut feeling says we can
squeeze a few more percents out of it with just a careful refactoring.

> > From dfac9a524aa8658fe63c03804cca9f0980b58ef7 Mon Sep 17 00:00:00 2001
> > From: Yury Norov <ynorov@nvidia.com>
> > Date: Thu, 19 Nov 2026 16:03:21 -0500
> > Subject: [PATCH] bitmap: Rephrase read and write bounds checks for sparse
> > 
> > Reword bitmap_read/write() conditionals such that it improves on code
> > generation and performance.
> > 
> > Tested with minimal x86-64 kernels with GCC 15.2 and CONFIG_TEST_BITMAP=y.
> > Run 400 fresh boots per kernel under virtme/KVM on a Core Ultra 7 268V,
> > using one vCPU and 256 MiB RAM.
> > 
> >           Before, us      After, us   Change, us    t         p
> >   Read    277.00 (6.99)   265.33 (17.05)   -4.21%   -12.695   2.97e-31
> >   Write   496.96 (14.38)  488.56 (10.41)   -1.69%    -9.615   8.03e-20
> > 
> > Bloat-o-meter reports 60 fewer function bytes in vmlinux and in
> > lib/test_bitmap.o:
> > 
> >   Function                       Before  After  Delta
> >   test_bitmap_read_perf             234    227     -7
> >   test_bitmap_write_perf            298    286    -12
> >   test_bitmap_write_helper          880    872     -8
> >   test_bitmap_read_write            800    767    -33
> > 
> > It also fixes the following sparse errors:
> > 
> >   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
> >   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
> 
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Link: https://lore.kernel.org/r/20261119191530.1716850-1-andriy.shevchenko@linux.intel.com
> 
> Should be Closes: tag.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
