Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8941BE233;
	Tue,  6 Aug 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722940185; cv=fail; b=X7nnC1egljjuIaChQN9xHQncQQ9cygkg0J229/VMl9x7PTSgyfE+uqp4orgrEI/S3++IQR+PDbuiAaoLthdGAuF7ciCFnOWL6haUSs85D/jExWS3oELEytb80JNoP0Bq5vhJwZ1+P9S/FHKEeRiOZVv8nZ85XZBbQrwFhu/8wZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722940185; c=relaxed/simple;
	bh=oJWbpHCh1aRe5Mkhlrqcl2HD6hKper1OQCVSYVkMG48=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQo3TCyWzr4MDPgpE8OH4Nq6dODFMD+vKM1c/9uEjDyh15yYydkh46arGJGQ2NaMLFbtLsUN9CqYNEKc6sTRkFUBV7JNSvd6BF4mra1CiP961AklPPt1STkYyphteLGrKZ71ZEPqGBqyd6JITdCJ+6nXXRXZahjoh8MOTGnn9vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9eGorb/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9eGorb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722940183; x=1754476183;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oJWbpHCh1aRe5Mkhlrqcl2HD6hKper1OQCVSYVkMG48=;
  b=V9eGorb/+8Y3drterEqe6AKWJGYZ6GnfXKrivG7J5B3jCsFzuJ+98a/c
   TvLYc7KFrt+NsrR0P0ZVaqKs2nSOfhQ3oRx+1QLpL1kKV0RFU07b5mk64
   WOMnMjhBpXUUtrd6KdMMYLECR9fNQ1AQrwF3byeA11EBLcp8i3f8S4Xso
   aAMzbmM3cZRuO9iPd5N3z56e5P/WQm/foUtOpWH2BVamTNzrVI63i8RWt
   HH0/vzur3PqAcJCHKYkq/MkSJKk0AhjNdhv3E2P1/jIQK8tmtg/joAZiW
   HX5H4h5vyWzdOIuo5joldZYilGUlSGFVi91cqHOLuR0ru1uAm7QX1jXfx
   g==;
X-CSE-ConnectionGUID: 5PGC77X6Se+njgw+m7J/aQ==
X-CSE-MsgGUID: LeWZ1BgjQmix9uNghDkDLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20616610"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20616610"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:29:42 -0700
X-CSE-ConnectionGUID: mvo2qyPfS3uVg9+RqnLSbQ==
X-CSE-MsgGUID: tNRO9SSvQdK9Z3YYpHXzHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="57043968"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 03:29:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 03:29:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 03:29:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 03:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf9fjPey1JKot5t+GimnsQ1CXwpw+JmoSWJr2uNSiJNXrrUm9mSkxKFBYphwD6SgUkQEVl8z0mpPTp1BFnzmnX78Vuoza3taYzK3zUFNlFygn7YHFyeIi4aZpbSCXVRqHxAi9wIEP1/5VxyVfAFyLn99zwEhDGmLHlx9CTjxjwSlwZATMtUarKn3Zy9ES/GzOEQDzV0j0qPABUjvDm8Qi32euSMT9++XMI3CA5vP22AmEhbKk+lIfhrTRxVrsKFgXAEaGpCCwwKpH5Y/4Lm1QYrvLW/a3k0acK8DIt3hSTxjYAJG+CNP20HDUEog6u1yVfrPWfVGlEhvLdRedyvLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/3ktGx5c7LfNiES9g/qruPBDpsQjXdht1kpowo8cpE=;
 b=bDlOlGXsWuq6WM5+pjD2fQzH1bIR/0xzYFHrPsIcu0F7ULSF+Na26RFEA2ZqIHsiWY56oYXtvZv4Q1IECXlr6SnUElxrMOB0IjWqDIaskDc4riHlrB0tqIMYFJavKnP0wQWs4EIKRwile3ocxY7UkjyWSLrAKNWKI+9lSuJaBWWvwsbD/ktZAtGR7uc+EzEgGT+HubFHXYX4ftbywzDHaD7LJmnyWoogPE1jsfNt27aEdoJFNkVm7SXRAHDCdhLi0uBWIyVeEXtkjrhPvNE63k+veczA7wdNIg1ira8IUX9IwAPLD071AR824AYb7fCWX1iICpZG4l/Y6Z9VCPkVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 10:29:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 10:29:38 +0000
Message-ID: <1724c53c-5a02-4816-a688-cae18db443d2@intel.com>
Date: Tue, 6 Aug 2024 12:29:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] string: Check for "nonstring" attribute on strscpy()
 arguments
To: Kees Cook <kees@kernel.org>
CC: Justin Stitt <justinstitt@google.com>, Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nick Desaulniers
	<ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>, Marco Elver
	<elver@google.com>, Nathan Chancellor <nathan@kernel.org>, Hao Luo
	<haoluo@google.com>, <linux-sparse@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Bill Wendling <morbo@google.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Jakub Kicinski <kuba@kernel.org>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Tony Ambardar
	<tony.ambardar@gmail.com>, Petr Pavlu <petr.pavlu@suse.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240805214340.work.339-kees@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240805214340.work.339-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fd74db-1f9d-4d60-9ed9-08dcb602ac8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFZpUENSMTl1OGFvc1hrNDhlVWhaendQcXBZOWZsR2x6eTlnR2VXMkZCUVNE?=
 =?utf-8?B?WUZHNlVaUjBadm1iMi82ZUVGOWN5NTJYM0hnc1VLT3NaOUlNdFM3azNxVG1E?=
 =?utf-8?B?WVRXV2NQTEI5VWFFS05lWUIvbWpSMTlCcVNXbW51aktnalNnWjJEdEJSTGhL?=
 =?utf-8?B?cnZKeUZwT2U1SDJETmI3aXVDWnNhUHVuRmZCc012ZGIrUm1wWHBJb0dyaG4w?=
 =?utf-8?B?VkdweXBaU1JvZ3JiZHFrZkhpZ2JkUzBCU2tCcUJWTmJBdGZVMWFYeklxWGlv?=
 =?utf-8?B?enJFUmIybGIrNGFZU0lwM2Q3MGRoT1JRRkJLeSs4VW15UUI3d1ZXYmJ4emxH?=
 =?utf-8?B?dlluUlZNU1RqQU5JcTJUUHhGbHpITlJtbTFYaUFlTFZNZnNndm5yQ0VHNUIx?=
 =?utf-8?B?NnRoYnBUOHJsMVg0elFOaWJiWTVqbkxLUHQxbUhrYWFmYVFYSUpZM3F1Nk5L?=
 =?utf-8?B?OFpKakUwOHphM2ZZTHVyUkpiUGEveXhVaHV0NVdscGhWVUZWMFM5TGY1ZWZW?=
 =?utf-8?B?aDBYeHFhNU5NU1B2bE1LNWxKTDV4Z21pbDNYUmw0Lzd1Tml6bHlHTFV1Ynht?=
 =?utf-8?B?WUJUbVdvK3hrSEx2blZQd01GMkRrWE5kaXZNamp4Y2FiY3dHdXlPU0JEaTZI?=
 =?utf-8?B?UDY5L3pLSkI3QmU0SzZueEVVQnEvRXp2RHBqZGlxeTdLeVZqa0hBM1pOTWY2?=
 =?utf-8?B?RHRpWjYwTEViZXE3Wkl5VXZtZmpMTFhYUmloSVJ6LzNIc21Oemd6dWM3THRQ?=
 =?utf-8?B?bmRMSDV6REhEK29GT3FkUnQrNncxTENqVkl1NVZ3bngzR0w5QkxOaEk5RXhm?=
 =?utf-8?B?UzdpYWlMdlNlUVd2VnRhVFNqOFlPeTFycEd5U1NqZ1U1SDdOaHFpNFI1YUVl?=
 =?utf-8?B?cU1OS25tNGV6NFVyNXdBN3JPL0FBMnRVeXY1RDhuc25iTlJTeHZ2Wi9mNk5K?=
 =?utf-8?B?VFZpRWJ2MlFQVWd0OWpPQUg2MlFwSy9XMGpONS85d2FSRDI1RW91RkM0djdQ?=
 =?utf-8?B?OVo1Q3J4S3BweGl2U0FEY2ZVdC9kcEMzSm04ZytYUnBKQ1FsTkgrWG9FRlBL?=
 =?utf-8?B?YjVtV01nTHpYMXlic0k5c0pDRXhlSnJsN3Zuc0dwWnlIa1VLUjd6L2g2d0x0?=
 =?utf-8?B?bE4rZTlhWGF1S0tvTzl3Tk5OR1Uvd3h5Z1VOc21UdnlaSG5hdUdtUkpjNDdy?=
 =?utf-8?B?aFVxekZxWlc4L0s4NnJFajlqbXdvNFVjRnF3emU1NmtVcmZSeFBITTlYMTll?=
 =?utf-8?B?TVV6dWhPZTlUU0RhdFkxVEp2RjdnN0tFUXFvZVcvYlNSVFErK2FpeWNhS2Rt?=
 =?utf-8?B?ays3RWE4aDlRS1lsQjFQNnBYMHdvSHZKNWliem55MWNWdFRqZ3E0UWxYUXdn?=
 =?utf-8?B?MmJGOVU4RU9yVzRrWStHeU9NU1cwMW5jeEFSeWpvNWIwVHA2eEhLY3JKdzls?=
 =?utf-8?B?N1hISWEvYnFlU1FmWWhpWnNEMXVVc1lRN3B2ZkpYbkVZOC8zZE0zdGlkU1ZE?=
 =?utf-8?B?eGRNak5kZHZtcWh5K3FxZWNkN2p5eFA3djZ4emJ5N2x5d2JJQ2g0L0VtSGFu?=
 =?utf-8?B?dlQrQk96eU12am5MaFBoQ3BucStrdHBCS0JFVGNvc0RRN1h5ZVgrNWlLWHhm?=
 =?utf-8?B?WW5FMGl6d3ZFWFlyZDNJdG0xSWRzeFZBdUhndEh3dnFpamVHclA0ZklQd2lJ?=
 =?utf-8?B?eFViTW1IY0ZmRzJFYW92bWJjNHgvNCtjT2xzaXV6NEJzYVN4REQ2NWozRkdH?=
 =?utf-8?Q?nGpgolll1O6gv2k7Zk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEREeE5RZDg5SE1Na2xGU1JFOWJ1Zkx0SHBRVWNJWFlFbFN5Q0dRTU9Hd1ly?=
 =?utf-8?B?SzIwLzIwZ2lqUmFIOG1KZjZPWE5QbWt4ZUZ2VUpFS2gwSFhGMDZTbWJKZnpT?=
 =?utf-8?B?VzZuNFNIWFdadWRyNVZLS2JoeXo5cXk5cFE5RUdQQWRrTGpIVEpuRGc1TTZM?=
 =?utf-8?B?dnczZTdLWjEwSnVyTFN0SElISHhmZFNnK3hELzdiRm81eE55RStNbTdVVlV1?=
 =?utf-8?B?RFlJeEQyK3FZTitETFJ3c1VOeGU3YlB5VVRkNlVTT3E3OFZpeHZrWXc0Qml4?=
 =?utf-8?B?YVo3Q0RMcU1qME1nYkdFU1c0WExva2hxNXhGS2FvK1FTbnZVeUo3VHB3Mitz?=
 =?utf-8?B?YlVXM2oyK3dSR0lKa3VsdklUdytyMjhqMWl5ZDR5Z2Rjd3k0SUg3NGpFNll2?=
 =?utf-8?B?Rk9oUElGVVN4a2pLcTByU0Z5U2Y3SGwzR2JQSGFvMjZYWUpodzZIRzE5UXlZ?=
 =?utf-8?B?TlVBcHdxQm5tQlBWbENIR3lqZFRRRXZkdW5KMzFzWHVIbmtmMFQ1eWZyVVpR?=
 =?utf-8?B?ODRUalJGN1M0NXpDTEdyNUwzaU9oTWR6T0Z2dWtGalVXcjJUUzc3MTEvVnU3?=
 =?utf-8?B?OG1YZ1F1SU4weURicTBFdmRGcFpSUmpUemVoKzZPREZ4aHAyQ0R0dGdENnBF?=
 =?utf-8?B?UEs1WXdmTXZ1aHJMcjBXSWZFZit0dUJ5UVE2ckIwRk9IM0p6dkI1YWN3ajVv?=
 =?utf-8?B?SmF4WGdDaWp1TURMWW5xRCs5d3Y3S0xXQ0dmanpmdit4b1ZPYUh2TThLNzUx?=
 =?utf-8?B?NmszWUQvVTNZa2xZczdKVVRESEdxZGljbHF6NlY0c043T0JaZWo0T05lZHBo?=
 =?utf-8?B?M1VrbllsUlBISmN2YkZ1dEN2cXlSeGNqS0ZJTjZ5RnNpdnIySTIya0huQkZP?=
 =?utf-8?B?VzQySVg4V0o4Tlk4MHNVODk3R1gvTWUvZkhScGI3SHI3WDJRUjNLUjQ4U0wv?=
 =?utf-8?B?dDNpeWJoTzBnblpjTHBwTHNCaHV1YkZNM0ozNlcyUkdPM3pZcTFmWGIrT1My?=
 =?utf-8?B?NmRrRmdxN1M1QlFQczJ5Vy9XczlsM2FpN1RMOG83YW5pY2RwdzBXcVhIOTcw?=
 =?utf-8?B?YUp3MHorT29vU0lMMVd6dVVBTklkVXUxMjRDU1BTc2hiR0EzQXVVRU5qVVNi?=
 =?utf-8?B?R1dRVnNkczRkYmErRTN4b0hQYThUWDUrU3FEems2T1BkYlo2K1E2ZnRSWSth?=
 =?utf-8?B?cG02bXplRGtWMTdrRzZabXdGUHBySTQ3MUpBRk5ybGxhNXpmLzlZc2VFN29Y?=
 =?utf-8?B?RWhuZ3VzYjAwa1JydDFyQjdPRDRBWnZ2WVJ2dFFHenZYTVZXN2JsUUkxZ0Zu?=
 =?utf-8?B?S3dHeVNHTGYrVTkwZTdCSmNIMy9CdGNVMHFielNzU2R1aW12TWlkVmpMK0hu?=
 =?utf-8?B?bHF1SmVsME5wYjRKWlNWenNNK1I1K3ptdXNxS1NvaVNVcmVmeHhrVkpKZTdZ?=
 =?utf-8?B?anU5aTdoR29RbTA0YTh1QVp6SXIyQXI1UWxVQXkrMFVFYmVPUnJNRGRZVzdU?=
 =?utf-8?B?aTdRL1duWjViQ0lTRXRSdWFOS3BhZ2NaL0ZCTEFhbkZNMlplUmpaRGZuUnFQ?=
 =?utf-8?B?eWUrSitRdVNRMU5WRlkvclBjODRxZVA4T2VQMjNWWXR0NUdkZnJZeUJKVG8z?=
 =?utf-8?B?cnV1Q2xDeDVSVlpQWkxYV25nSTEwVGxnMjBtdEkrY0FyaTV2SWQ2Rll5ekNV?=
 =?utf-8?B?b09mV2MzR0M3a1hybkp1UG5udFh0QnRNaS9abGlHV3JNQjI4Q1llTVY3TlU5?=
 =?utf-8?B?MDFLZnFWRUFIZkd6MElNVFVSaDQyWnJ3eUZHZ05aYjdOZFVRSzRZM2lCQVhX?=
 =?utf-8?B?bmpNWjNRU0NWSVNibHFSUTJWNVBIWkNWOHBWODJpalIxR2h2UnZDd25EaURs?=
 =?utf-8?B?V3FLaUJQbWZYMEx6VGlySTN5U0JTLzBFSnBpWFZYYWNzYjUwS2dXSG43bXVn?=
 =?utf-8?B?TjVPekFXK1dEaXAzbCtDRjRjcU56SFh0OTBuT2pRSEplTGRtZ1FnWDUzeEdP?=
 =?utf-8?B?NEVwM3pJakNxSHIxbTJoZEZDTW1Ud3hvclk3Wkw3WXE1SGQyeVdsdzJERWhv?=
 =?utf-8?B?bTlOeDh3Q0pjY3AxTllzZ2ZIYmtWWlNVL2xJdERKTy9RWktjNndCSUlxdlBj?=
 =?utf-8?B?U29QMDZVdWhiZGNHYlRCMzF5OXZZK21SeXppNWJOZjZuQ2Y1SFhKRDNWRmd6?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd74db-1f9d-4d60-9ed9-08dcb602ac8d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 10:29:38.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGEtziuyv8B/oAm7cZJqjllS5qa0VW9wVA2mvqkO7rHsi93T+gBpalHQ/7cpoIRFZFPok7pLxEVVhtAHX9OGE+J1mPDiHbYPeCt4lHZMqdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-OriginatorOrg: intel.com

On 8/5/24 23:43, Kees Cook wrote:
> GCC already checks for arguments that are marked with the "nonstring"[1]
> attribute when used on standard C String API functions (e.g. strcpy). Gain
> this compile-time checking also for the kernel's primary string copying
> function, strscpy().
> 
> Note that Clang has neither "nonstring" nor __builtin_has_attribute().
> 
> Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute [1]
> Signed-off-by: Kees Cook <kees@kernel.org>



> diff --git a/include/linux/string.h b/include/linux/string.h
> index 9edace076ddb..95b3fc308f4f 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -76,12 +76,16 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>    * known size.
>    */
>   #define __strscpy0(dst, src, ...)	\
> -	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> -#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
> +	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +	\
> +				__must_be_cstr(dst) + __must_be_cstr(src))
> +#define __strscpy1(dst, src, size)	\
> +	sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
>   
>   #define __strscpy_pad0(dst, src, ...)	\
> -	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
> -#define __strscpy_pad1(dst, src, size)	sized_strscpy_pad(dst, src, size)
> +	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +	\
> +				    __must_be_cstr(dst) + __must_be_cstr(src))
> +#define __strscpy_pad1(dst, src, size)	\
> +	sized_strscpy_pad(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))

any way to avoid the usual caveat of repeating macro argument?

a variant of BUILD_BUG that is checking argument and otherwise pasting
it would nail it, but I didn't pondered how to implement such

