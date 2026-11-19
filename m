Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.57.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795123456;
	b=CBqHUIFUDR7mB7UnYY5d2Zk3SVtVIaFAyfjevOZUFO70Hl1dDfeSfLZK6KHCfWdxRxle
	 AxsB7FHOmy7G0ozg47AlGcJJxjJ151uAD5gIiS1LHAXdUF4rggL6ZgCDtwIe1jl8XQeiF
	 eeM1pry3gRFMPmo1tuKgLAhLgVV1Os3bH2TEAnXb+RuYv2Eupaf388mwproZFB+K7Xkd1
	 54qfyc60x2ytkvaHKUIylbcB6lYvs6I0qzlyt6oqnKeChGM2C7mjTkJ3q5PMF7pC40Til
	 MhVprhd8U/RT6yettqZSyDiec8wM97pJb48Rph21nrE6J9rAugoqKqPm2EshAMYJ+MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123456;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3PjR76EXEbXCCjg1CxT6GKlQ2cnPvVeZ2b7ni5nuzNA=;
	b=UUyO4i5owlDzJhGZOJC9ATUzvx/QU3xzxWT3JFcKtD1Myv1erqgQmgl5H0DaqZb3gsNE
	 mW3Y7QCqdTbypxZ9BMVi2L+gUsqyLqoOo0Cj4dE8CRQqZf2FdCIume0kdw7r7yncQFFnL
	 ++oz9k3OqRzGa+nAC/90rlIsVuwz6YrQ8bpHBs0TweBFCMCu8P5Ulr3LtLDFUPNqZkhJl
	 HC2rWFAs8TuLRsMTMvGR4uYj9vkHn9ToZuDSNXFqvZMG3hjV+AoTJf7rw3fMM2A5kpMfV
	 I799CoKBU2VtmpNfXFP+zf1cUBVoH/SQ2f+04PJdiofisxxjaYqAy9FxBfNdL0WPU5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E3Eo9POK;
	arc=fail smtp.remote-ip=52.101.57.58
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F697606A32C;
	Thu, 19 Nov 2026 21:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F697606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E3Eo9POK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLynoKW7IyYhNlk2CfyxwiP5cm0shmwRF+/y36KD2RSkaH2NIJmvplu3rG5KYKV8GeRzFB0LPxZPYTPW9Fb2+gSqM2LTMWwrUnAQ6oq+kkxqrktxi9DyLV7lCNDWn7jcnvrIL42ZlhfqC1V3dcmFG/sZ1EKBVIlSP3daaqS7soWXlHAUUuZri4uLFk+WgLimShkwWM43TP3pjQ3YxUL72c6tVnvW/bknj5rPdEKEo+0k89ppP6o+qnvqwIbiBkX4UlqaTBNMsues9RzfXxubm3fAolclGDGQnjD0HjdE3wYPOS/ustYM1e6WYwxzt6lxlgRNh0HtK0Z7K1awuBKP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PjR76EXEbXCCjg1CxT6GKlQ2cnPvVeZ2b7ni5nuzNA=;
 b=SZ0rulvkqL+/Jdn5hI0oZxL9nSS8H7SKXZv1WFnzL+6H6X1TAHZq1q5QNgaEphGnx3pBa/AlMTOZ1ZkMSTEwZgCJ+9nxrjvN76I6/iNzUDe4viftkjj+LunY2PSxaI/baJ93N0x01mYhHvAxnNECONIXOKExL5QiMnnr2iqWVbqcrg27uzoPz8Eid88jyQK/kslJhCitKYYRb6MVgasOz0EuwAhlhkDz6zmYO3bU3Zey7cYZF9VbW2ZyXMOUQyIZQwkz8k0vDXG0KrUYEeXhB8R74r599n3Wxg3s6HOMhK6Ei8bDhzEcP65Id28sIxi6DPf3DmeUR6Kiy06lPBzEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PjR76EXEbXCCjg1CxT6GKlQ2cnPvVeZ2b7ni5nuzNA=;
 b=E3Eo9POK48K5V13ZpVVRazTOv5XQ2uIV1UM4ZhdheVY9QeE/YNAgfj8c23p2hhNo0k02WwW5nhyf/r31pTH4kwzLv2CKggwdmuXRTd/m/cuNT8Gc3j0oVj9M2znKnXRKPrQO0RKPC9xWMqn6nbGnHnx2q8Vom94Obl6e902ZDofUoy5a40rEwSsFN0zgv4BYgNO36BMdJNX0GR2tX6gONR6t6kncKgWGgXrylIqxz1OlWafQ92blqLEL4aJwUSHRLmuDTKJkSxd3+RuT1Qghq8S4WWRcqZEUYsuCpfqg3y8vz6god8ojCf63LUGhGuCIBfuu9U3ETaQV5s1Noe4v1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 21:22:10 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 21:22:09 +0000
Date: Thu, 19 Nov 2026 16:22:06 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jonathan Cameron <jic23@kernel.org>, Chris Li <sparse@chrisli.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v1 1/1] bitmap: Refactor bitmap_read() and bitmap_write()
 to avoid too big shift
Message-ID: <av9ofhBTAcMJud_-@yury>
References: <20261119191530.1716850-1-andriy.shevchenko@linux.intel.com>
 <av9eAde6AKlAKWaH@yury>
 <av9kOeZtIjOtH2yp@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av9kOeZtIjOtH2yp@ashevche-desk.local>
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1a3f17-5fbc-40b1-d749-08df46832b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|4143699003|261026140227099003|11063799006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Bl9mnv2v38L9Su/fengdJTTbZmbWi4CTwbwX44tAB5rU6hXwytN0yxWjBcJ1MEwkHog0Rm11ydAu2QKol+lOIadFoXEmb+Bk3qhD9EhU5/Ufut6SYLNFq2VKX2BtBqeWRw/X8ca4eQt461qebDsDsKAPR7WZf+56p6mlFcS81hOnBL62GwVjMnxy80qH7QPX1BPlmLVN5doe1kZvZ3MpyYrnNY+tHF0Ut/Wvnc8epFJlKbz5ESPHyHgJzE0taTuR6YCltBx8wVmBEQ7rDmB5VfNYD6z3K82mcRv/KTkfpGGmRCgFa+iTJ2q04mxlbsU5Nry0KTSzHGcnvk4h9GQdjmv/HtsC1vpwe9OjBU8wSMq1hG8Uh/fM/ytG1aFzcFgkZxzULRmCO01IBfY6F3jKKL6/+lVeeNtVCKTjcc0/VW9euIXV2perw5e6xo9m6o4pgqmq6tNUqljrTIrmQ+kvKQOGfpfpZrhpDtiUEFe8ijeQUZxRIbqzWt6jW16hIBdjTY2pOAd32qdjtNh3IEKpLdT+MpCC0lYEgmwv1gZ++IADIQ5fdVGg5eBIxUeMDq1evnD2Ud8vlVlr0q4LQEj03WFPcEHpGdV/NLiT167cSH1trkjh9qyRO5awacfTGSp2RjR0wNIyW13UeZLr9hZljYC1v4o9hq1JMAu+8qi0suc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(4143699003)(261026140227099003)(11063799006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG1zZytjR2hEMk1pZWR5Rk1pbDZyN2RkdlBBSUhmMVluczNJNVBQVmY5ci9h?=
 =?utf-8?B?bVJEOXlCRUdITURuYzdPa25pbjNhMGZOTWpoOG1yOFB1VWRxS3lXWjRqOEhm?=
 =?utf-8?B?dGgwZXBuOHZQSlVBLzFnQWs1VkRsOUNrSUJIbXE5alBzQm9sanhrUFZPT3NP?=
 =?utf-8?B?VnAzV2pRWkJTQlE3Z3NncDRsVFo2NkcvOEkyK09mK09pMjNmMUkyelJiclh5?=
 =?utf-8?B?RHQvMWhSNEwxOWd6NHpyZTgyT3k2SlJkcVBCeFUvbE56b0hBRXFJYVR4U1ZP?=
 =?utf-8?B?MHBXa25ucFZHM1BDYTgxZUJVK1ZUNG1OS2dhV0JnODBBbXlINnE4eVRlbXVN?=
 =?utf-8?B?RkJNdDJONnpQVGsxc0FBRXcxVmlEa3cwSkt2dEVtdGJkQVgvcmg2eGVhazVu?=
 =?utf-8?B?aFZzZ0RTS2MxVnM4emNlSUh0ZFl2THc3WVpmQzlsWFFObCtNenM4VHZWd1d0?=
 =?utf-8?B?TzlrSmN6YWJZclprbEdFZFI4RzdYVmw5LzdYcVZNam4xUGxRQlNoeitTWHJR?=
 =?utf-8?B?TjBXRzJISlFVMTNobDBmOFVaYlFGdnJkY2NOTXJHR3JkdjVUYjlDT0MrNzJS?=
 =?utf-8?B?aEVoRVZCcDhTVHB4RjliTjlhR2ZTa0Q0UnkycWtRN01tbnlkeGIwTVUyM0Nw?=
 =?utf-8?B?aE9Bbm9TR1Q5cTRBRW0rZWt3a3JkTUViN2NyYXhZd3VYYTBZb1lEbkh6YnVF?=
 =?utf-8?B?RldjQURSMUQxaDk3bFdGaGtTSlUzM0dpSmM2Q2NFTUlyTTRwNkt2YWgweVlR?=
 =?utf-8?B?bVZiT2FFY3B4MFVjYnhjbXdDYTVOcEp0SVVnRUZ3amI5dW9jRDI3NSttdHpl?=
 =?utf-8?B?bkpXNjJDM3pVemFyeldjTm4wZ296SjdsdVhsWHUzTzhZekZobXlMdHBJQ1V2?=
 =?utf-8?B?bWVva3VBQkZWZ2djMTUzWlRZWFRaVkQ0d09CQ1E4NW9YQWtpMkUybTFWTERS?=
 =?utf-8?B?ejRPUEx4REFFbHB4U29JTzJGU3RIejNrT2xYK3pkWHBzOURkb2U0aVA0OThR?=
 =?utf-8?B?bFc4RTNWMWxUZ05JekpodkhCOUgwWHUveG1McnFkb21zUGxoVU1TNmhpdUM1?=
 =?utf-8?B?emxpUGY5YURHOVE5Z0lPVnJBbGFqRXoyM3h5ay9PeURUVlA0RlJKejRCMVE5?=
 =?utf-8?B?NFFadXhiVWNyTzRZYU9hbk92WXJhR1o1Q2dqd3d0VXpIN095TTJRejZyK2w5?=
 =?utf-8?B?eVY0cUpQbjNMNmZLbWI5ckVkVFJQZ21zRXN1RTNXQWlJR0s2VURwZ0U4bGR0?=
 =?utf-8?B?bmxueEI5MWt5K0p2MnVxRFZWK3BOVk9KVmM5YzVOU2RUWnQ1V3ozS1ZoSS9O?=
 =?utf-8?B?Qm1PNmRpMXdOVkREMW45K3ZqVnRsT3BoNzQ4TFdUbjZydXgyc3FHNnhXNERK?=
 =?utf-8?B?NHdXc1lyZGxTVWdsMVJlMWpkMjlYSVZtNDVuOWpRYjQ2U0lNSDVHdjd5RDZJ?=
 =?utf-8?B?VjRhbFJQN0xybnRlSFpkNUpQcG5CaG5UUGZCMEZ3Q0RwT1pOV083WmVHa2xv?=
 =?utf-8?B?ZnpnVzNsMFVsanh2RzUxUVRha3BBK1hiSzNHc3ZHS3RydStOcFdiN3p2VE9L?=
 =?utf-8?B?QlBUSTlzRk9Gd25lTVZwT2hPcXViRzA0dE1abjVxOWQvKzZVY2xsL0RaMnBk?=
 =?utf-8?B?VG02M3hGL0tteDl3eUtRTXR1SlIvSi9Gd09GaW1ZOW5IYTdxWlQ5eDlDd3ZF?=
 =?utf-8?B?K1lmeWg5NFJRakxHTWdsQXJiNi9STkd3OWtnOTd6THlMZ1YxQ1lQUXVWb1Az?=
 =?utf-8?B?ZUpUYUk0UWJYaDBoT2F5Z2JrWVdPdTVPcElrcjRIL1dWRlRCVDZwd29YUCtE?=
 =?utf-8?B?eWJ0OE9EMHR2amtxZExJYVFpam5sYU9Qb1RzRFdBUVowQ3BPYzkxRW1wVldD?=
 =?utf-8?B?ZHNMOUJraDZIM3BLdThKVUZJcG9ienlWb0Mxa3YxRTJKWXkyczk3NUFZeEJQ?=
 =?utf-8?B?S0NOT2hJdWZvV21YelJFbzVLTkhtMmxvd0RKZkl1K0VoNnd5VnBZRXI3ZUVy?=
 =?utf-8?B?Ui81TlF6bFhwVTg4bWg2dDdnZDhQbjNQNk9rREw5M1g0bUpJVnViN25wclNZ?=
 =?utf-8?B?TTRHUzRtMWN1OS9RYkN1L3dmR1dCU1Q2THRXTTZIcWFZZyt2N0tEa0x4RWJY?=
 =?utf-8?B?dEVYNVoyc1JlVndoNUFKMXdDd2pwNy9JWUlYY2NsZ3BEdGtPcDhUS2RrNWFP?=
 =?utf-8?B?YmxocEkyV212em9VaXZuZWxScTE5ZDRBbUE5Y0Vxc1k5T2FwQXhQMS9wcW5q?=
 =?utf-8?B?VlVSK011SEdhMFBHNVZWV3Z1c1lzUHNCeHhqVHEzWkxlSkhmRjAvd2RVNTdy?=
 =?utf-8?B?NDc4WjR1cTNJc2NLWkt0WGJNSlNCc2MyZG9sdXhJVC9FMlVwRU5NODErSnNi?=
 =?utf-8?Q?4q3IhX5WMn/uveKSu3s4tx+6U7x3kb9m58jnr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1a3f17-5fbc-40b1-d749-08df46832b6f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:22:09.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yZ81Kv62MqIl5PiX65L7uarom1kR0MZfr8j/PCbwcNyMXoQnCP43yW0Qogokhm9uzKQ8enNh+ZOLFWMvWGSJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123

On Thu, Nov 19, 2026 at 11:03:53PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 19, 2026 at 03:37:33PM -0500, Yury Norov wrote:
> > On Thu, Nov 19, 2026 at 08:15:30PM +0100, Andy Shevchenko wrote:
> 
> Thanks for review, my answers below.
> 
> > > While compiling ad4691.c I have noticed the following warnings:
> > > 
> > >   drivers/iio/adc/ad4691.c: note: in included file:
> > >   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
> > >   include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
> > > 
> > > Since the bitmap_read() is called with statically define 'start',
> > > the 'space' local variable becomes equal to BITS_PER_LONG, or 64 on
> > > 64-bit machines. The 'nbits' parameter is coming from the run-time
> > > defined value. Static analyser doesn't see that the right shift
> > > by 64-bit can't happen — the space >= nbits check guards that.
> > > While Jonathan put it as false positive [1], we still can give a hint
> > > to it without growing in the code (`bloat-o-meter` for above mentioned
> > > driver shows no difference in size). So this is what this change does.
> > 
> > Jonathan put it right.
> > 
> > If the analyzer (assuming sparse?) throws false positives, we don't
> > need to change the kernel. This is simply a wrong motivation. We need
> > to improve sparse instead.
> > 
> > Otherwise, the kernel will become a collection of hacks for various
> > poorly written tools. Let's do it the other way, please.
> 
> I agree in general. However, we can sometimes give hints without breaking the code.
> Now, thinking of this, the mentioned check can be done against offset leaving code
> generation and sparse happy and have no unneeded bulk.
> 
> > > For completeness, bitmap_write() is also refactored in the similar manner.
> > > I have also checked a few users of it and `bloat-o-meter` showed no change.
> 
> ...
> 
> > > -	if (space >= nbits)
> > > +	if (space >= nbits || offset == 0)
> > >  		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
> > 
> > So, doubling the number of conditions, and the new one duplicates the
> > existing check. This version suppresses sparse false positive:
> > 
> >         if (offset <= BITS_PER_LONG - nbits)
> 
> Yes, you beat me up to it. I just was thinking about similar check in the above
> comment.
> 
> > And even with that I'm not sure we need to touch the kernel to make
> > sparse or whatever else tool happy...
> 
> It might take ages for sparse to fix even more annoying issues (if you remember
> something related to cleanup or alike change in the kernel and sparse was
> lagging for weeks).
> 
> ...
> 
> > >  	size_t index;
> > > -	unsigned long offset;
> > > -	unsigned long space;
> > > -	unsigned long mask;
> > > -	bool fit;
> > > +	unsigned long offset = start % BITS_PER_LONG;
> > > +	unsigned long space = BITS_PER_LONG - offset;
> > >  
> > >  	if (unlikely(!nbits || nbits > BITS_PER_LONG))
> > >  		return;
> > 
> > Initialization of local variables before the sanity check
> > may become useless waste of cycles if this sanity fails.
> 
> How? they are not used and function is marked as always inline. I believe
> optimisation in the compiler does the right thing.

Maybe yes. I've seen quite many non-trivial compiler decisions before,
so I want to make sure...
 
> > This is also not necessarily needed for sparse happiness,
> 
> This is to make both look similar at a glance.
> 
> > I guess... Let's keep the patch minimal?
> > 
> > > -	mask = BITMAP_LAST_WORD_MASK(nbits);
> > > -	value &= mask;
> > > -	offset = start % BITS_PER_LONG;
> > > -	space = BITS_PER_LONG - offset;
> > > -	fit = space >= nbits;
> > 
> > I don't like this 'fit' thing, and would like to drop it. But
> > let's find a better motivation to do that?
> 
> Why? The fit keeps the check I want to refactor, since it makes it twice
> the code with that ternary looks ugly and unreadable. This is exactly the
> chance to kill two birds with one stone.

That's what I meant regarding the motivational part and minimizing the
patch.

Thanks,
Yury

From dfac9a524aa8658fe63c03804cca9f0980b58ef7 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@nvidia.com>
Date: Thu, 19 Nov 2026 16:03:21 -0500
Subject: [PATCH] bitmap: Rephrase read and write bounds checks for sparse

Reword bitmap_read/write() conditionals such that it improves on code
generation and performance.

Tested with minimal x86-64 kernels with GCC 15.2 and CONFIG_TEST_BITMAP=y.
Run 400 fresh boots per kernel under virtme/KVM on a Core Ultra 7 268V,
using one vCPU and 256 MiB RAM.

          Before, us      After, us   Change, us    t         p
  Read    277.00 (6.99)   265.33 (17.05)   -4.21%   -12.695   2.97e-31
  Write   496.96 (14.38)  488.56 (10.41)   -1.69%    -9.615   8.03e-20

Bloat-o-meter reports 60 fewer function bytes in vmlinux and in
lib/test_bitmap.o:

  Function                       Before  After  Delta
  test_bitmap_read_perf             234    227     -7
  test_bitmap_write_perf            298    286    -12
  test_bitmap_write_helper          880    872     -8
  test_bitmap_read_write            800    767    -33

It also fixes the following sparse errors:

  include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long
  include/linux/bitmap.h:854:55: warning: shift too big (64) for type unsigned long

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20261119191530.1716850-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index adafbcf2016b..08de1467367e 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -846,7 +846,7 @@ unsigned long bitmap_read(const unsigned long *map, unsigned long start, unsigne
 	if (unlikely(!nbits || nbits > BITS_PER_LONG))
 		return 0;
 
-	if (space >= nbits)
+	if (offset <= BITS_PER_LONG - nbits)
 		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
 
 	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
@@ -886,7 +886,7 @@ void bitmap_write(unsigned long *map, unsigned long value,
 	value &= mask;
 	offset = start % BITS_PER_LONG;
 	space = BITS_PER_LONG - offset;
-	fit = space >= nbits;
+	fit = offset <= BITS_PER_LONG - nbits;
 	index = BIT_WORD(start);
 
 	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
-- 
2.53.0

