Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814F5680
	for <linux-sparse@vger.kernel.org>; Wed, 27 Dec 2023 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGgkTvhX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703664036; x=1735200036;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=bZuYmT37HzooHpbHiUgJ8E/JsvffivMqteSy3QCXMdw=;
  b=gGgkTvhXnXHZ3sAAxLa6Z4Zzdoy3OWlr/GYlZIlTp3i6PsQbR4CHUpN0
   1EEMfXGkmIrmhoc9LttbMulR54ewI1zXkhYgKUUxrMSUhWlNhqlO+yJKE
   oh5qnLQDL8eZZj0ViEeo5mueaJBtGWuaMJql6fbMs8KjdW44MANQCAF6S
   zwW/ZIcA1P9Fcv7hNEzv+wFa17ThE75OLzGf9gAmOX5/ECVjliXEKenct
   DOYI9YPtb0MbBGsKEvwm97OEKOQPRN9+3rfIT4iv+8x4AXkIlNCvhtTOq
   Z6lFBgJcYGiijnjT4039aszTpUWzXZejrUKfi3Y8en/CnMQ86a8m7uCLS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3510564"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="3510564"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 00:00:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="754392214"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="754392214"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 00:00:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 00:00:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 00:00:34 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 00:00:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBuEcLVEbx7UUFmhI+3AaHBZ+a1NjoIq6hY5hvmq1QKMW6nKiJtZhrRH6XpX4JdhPdfc9ENc+h6BH4pE/oWZTFCkwFV4nyB2Hp58FmrFgfFnZhwHuxGCLHk8RuQ1bJXCTV7HPn7FoTf3pR9YtXOsURIF2otRJxZQHCLclF/e9Nve1PbqMu/ajv8qz24V2MQnbHL5lexO/D/zFyWFKEOmkHxWb6Dcrvs9e29Tby3XBK+IrISNWQ4i/00Fk3Hbcf3Bwjg43KEhYf1csPZWCpu6D7vvGDEl2uzMuy18knZfNuR3j1TdCeuhksHi+ieHVFIGCNOWMZtRFjbvArp8lw1Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZuYmT37HzooHpbHiUgJ8E/JsvffivMqteSy3QCXMdw=;
 b=OyTkLjWdYtDQFF2tKM89Q4feziPeo0LuIJs17gH/jOAIYhqNv5chUr6d2URZ3+P6cctfwoGgesmFUP5uCVkvCWeH/vwPdbfaSPWQszSWI+DAPsY/hBlrAEIoErO7zQLIN95eFcYUsTi0ivOkBGKDVsnxtr+ULWrF9HXLSxLCm+knMzCxpwrZbzdjDnW+Rp3vtZLCJBd+oRWNMSnIqpISYJKcluS95vkb6n8jGOPeVUSdfeZFdHoKRokiEf+nmyAokmjHfUXzjc0jW8b7St0K4I4G7HpcRovZyC3uIE2vvSqn5ck9M1HMcCqt5odk9aEIfJiC6IBsSzEyUqBYlHB6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5869.namprd11.prod.outlook.com (2603:10b6:303:168::9)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 08:00:32 +0000
Received: from MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::51ad:7054:17c6:c6e8]) by MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::51ad:7054:17c6:c6e8%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 08:00:32 +0000
From: "Herbert, Marc" <marc.herbert@intel.com>
To: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: Re: Infinite loop in delete_pseudo_user_list_entry() bisected to
 commit "cast: optimize away casts to/from pointers"
Thread-Topic: Infinite loop in delete_pseudo_user_list_entry() bisected to
 commit "cast: optimize away casts to/from pointers"
Thread-Index: AQHaOJgfUft6I+eAS0eEEBK7uDAAIbC8xEeA
Date: Wed, 27 Dec 2023 08:00:32 +0000
Message-ID: <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>
References: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
In-Reply-To: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5869:EE_|PH0PR11MB5191:EE_
x-ms-office365-filtering-correlation-id: 0557dc4f-5d7d-4ad1-7fd1-08dc06b1e64d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2j1FtkTIvJL6npqfRc4SLehLNsB7Zmfph00+IAq8euabYSIOJX9HNw+DAKvtVERhBhldGyVVm4aK4FPWnSls1esqu/Yb1uBnbM3Y+8v1l11/6ZVvRWdI/TIJiUdxmFeENqzAPcwnRjex0Q3bRCB7EW+0FCmHlPHvRhNV5Kf4b3mgykTSTc1IzEDLizfFGfMKJhBf4S+5KVg0Ciw4f7w0ApWd/OSPzfiRyWIgM1zo3nPwvVHvNs+bSZ4P9ems8565cLZQhKKThmHx45xAZXhRHlWuI8qk3xWjHpeBy4hHSmFhWPdtxg4eH6QrYOqu/WAnDFnVy6RiCSXz4/Ye+5/jqypRN5uphwWA18UsF9UvHhWuD4x4UtK6HCcml892FRIwFYeJjTzObC/7jJFX7a7T1DqPrcb6USLkfvjS175aJY4BCfkYJwRxFQ93iUW6G7AEwMsHfq2/PtyMl6q6noIJI2Vwb2FHicdpENGNilGYmQtPm9VHOzToJtEuCBejJ9meuQoZ9yBao3A7pZGHKB13ZJpM+BeXbrTixy9dAgNN3g3bU3bqaB4qiq6wMjfmUfMZ2Cotldw8LMxoxi1GJe59GG3AvW91bWcSSNkB8X/IKq58hj41gFSCL9ya3r95eMdeR0qq1eAXyCUZiUcSOKgrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(2616005)(38100700002)(122000001)(26005)(8676002)(316002)(82960400001)(4744005)(2906002)(5660300002)(478600001)(8936002)(6512007)(71200400001)(6506007)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6486002)(966005)(6916009)(86362001)(38070700009)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?joTrJXjA/TzYWGRC86mgsMhLnpkAZN1/2ZG3/azW5lTRqBQcQK4ayR0L5rwu?=
 =?us-ascii?Q?M1XDwv4JKeTvPA/ao+eSR/iNihhTZ1lCDkczD905JF+/OPF1kiR2xCeUjnB0?=
 =?us-ascii?Q?242SPVpZMKinDbI0kluL+zCCEl2XH4+WH268HIyI8NbfyFl5cewO4J4Gcwrg?=
 =?us-ascii?Q?UL7MoxqUVcyU1V1b5TbdEenHP17Hjpc6hh5JGk30JsvUAaOvvvHLAiKZSaot?=
 =?us-ascii?Q?PRwjPHJB92c/ht3qfCQUZvoC6DhdH0aZWHkJfO92PAM6nLaFNxrVv/hijv0H?=
 =?us-ascii?Q?vJmI6ZhwP6686PdExFC11xrpn/1opS5G/2ogSYrePATonFryuuyfoXbnjuYA?=
 =?us-ascii?Q?l0IyQKhj2yi5QeUmfxkUlO0IuCioBNoio9AA7FR9aA5BA0cT/S0plLwRyo4U?=
 =?us-ascii?Q?Kmv/oEbvsiqhg96flfw6RHhgKhOtebjjEsqt4f43lmgVrbVOarcvJDvy5RC9?=
 =?us-ascii?Q?jEfBqkTzcu8u7M5fi4IAJLM2wqtEDl8M4S0DvL4w3oFtBr4lKzoDi0qomwgn?=
 =?us-ascii?Q?YaHc8/gzzjhYECHCrpVOUYet4OR73heDD3l9GzA0UXxq3RKroSvsPDKfMNYI?=
 =?us-ascii?Q?/TSRl/WXeIyMegtGTLAiiIggIIgPbqO9lnvsyJkYGp4HT/7Z61qd+yhzMgDi?=
 =?us-ascii?Q?g6tZ5dGVhlMSZ+f/PQCB7SqC71EGmLEQMF8htc/XonvRISOyoVJGdnf/Rlni?=
 =?us-ascii?Q?TPs3WZIF+fnostOlYtKSCWHdUqyuca6pGthaDNmkFx0M81XyDZbNDBYO6z8E?=
 =?us-ascii?Q?GLlue5cIWcYnb8Xitzzzl/OWX935g/mG+kkqLfxD1ZHljNpRIMF+3e7Qk/XB?=
 =?us-ascii?Q?rTHmPwz1jkfvCB/wE4phb1mhFcrSmrlsz6oyO9JlNtJz3Y1uKWezZKH1dUeB?=
 =?us-ascii?Q?b8GO7basGhpSJ/6ffXdcLEtMAGiSI+8bAIc8HzNMvB57C8P7caq7mMQQO2IZ?=
 =?us-ascii?Q?QI/tYfNGwbVCBwGf4a10hv2eIAhWC4ag/0HzvNY9WNJUX7hSykq7lCT66RLq?=
 =?us-ascii?Q?CSdRfTqm/ej427PH+9uIecoQ05xhrvaGzZtlkRi4DFsGDg209bTB3N1sr0pK?=
 =?us-ascii?Q?PXn31ETPPqhyhDJ80pWQ+KwkrGcNUq4h8IKt3/OVziOwnWjkXrEigjcaW1Z8?=
 =?us-ascii?Q?izzhFnKeMEXaaRUoLvayZxYHVvu1qhCkwhgNYXGrC+0W+I0LRrh2wFVhHrxh?=
 =?us-ascii?Q?IZ1kZs6mtptr7mgTIWwpA8do78AgARUjdvg3pcm93zYewSaetcbEY5qj+A/T?=
 =?us-ascii?Q?LYiujUG/pS6Ul8eOFvGSf4csJ2A05ECc8pwXgeA3Vmatr9qUUAPGMaBZZ/Nl?=
 =?us-ascii?Q?jpWo4kvqBD5PpQ9mH8UIPNrz0oPfjQB1RuTWoFJEXeUWoZzudjLLPtvYcpsk?=
 =?us-ascii?Q?t4hZ0MKzlr/e0ROIQmxJbjfjyamo9m0yfGnkUuUhKUj4jgOolAQ7dJkBXy2C?=
 =?us-ascii?Q?svGyjph4oHDCOR3PstDW1Hj5sDKSExs5jkangv8HsiPAzqwGgrRC1cyB3ejX?=
 =?us-ascii?Q?sSirfDpOffBVDOqqfXPREJCzTMQwv9STHw4RsxyhNux3+Qqk6ECQKaCZjoiF?=
 =?us-ascii?Q?hh/rON/3UI6DXl8CtPCwuToSCJUffjwk+gbCWs+ZuD3j0xZ+61g3ER8lQya9?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48F400DCD451574B8215AC7423408080@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0557dc4f-5d7d-4ad1-7fd1-08dc06b1e64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 08:00:32.2315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5B4jMJfAYAFQK/3iHgF/ZE1bPlYrddFRg3i7BfqtHz9jHwahN7OS8JoeG0RkzCH86WBMPnBmDOcHAvGaOdwxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
X-OriginatorOrg: intel.com

Hi,

 I just bisected and gathered detailed information about a 100%-reproducibl=
e infinite loop in simplify.c:delete_pseudo_user_list_entry().

If you're interested please take a look at https://github.com/zephyrproject=
-rtos/zephyr/issues/63417#issuecomment-1870029877

Marc

PS: I'm not subscribed to this list.=
