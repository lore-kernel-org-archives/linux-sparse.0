Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85B643
	for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2023 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4XpwaWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703725716; x=1735261716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7OtET2K6Uid3WiZPDPqIvMb3WmZTfTkRqLJ7s8gPZrg=;
  b=f4XpwaWZEVFyQaT0Yh9mfwSBHB4XOUmfHWAi23CBVij1EtXqkSS4F14u
   sFvv9YKwzkRUnbPBJuVyj/X0z8J6VKIGZt1EJ0CVSQAiNo9urE9UPCO/4
   lLjBSHEt6QrTfWbuTXYG1uVcS/uEhlBaSss/MI2c5t8OBZaSK8lnqLmZ2
   sxQCFgh2NsmyMXnPG8nkGTovGA8+HkYiAcd+Gvzt5ByKzfT5abao1+7Jf
   tnWMmq3ZcxwAyuqR5Wn9CICbKYYE/2CLB9UNkm1yY5fiZqqZRTMpY2kJC
   N2hA4+T2LiUYaDconpfgZ4PoqBpgyRMRtK0xeRF0rylMHBi0jABNw9Ssz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="400309665"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="400309665"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 17:08:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="728172148"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="728172148"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 17:08:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 17:08:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 17:08:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 17:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gso4af+ez8grpCTcm4YcJxbRmjMpMIOOGdBTsyNQ11prHM88H8mcAa+djAiADphclzMqLlu2oY5iZKaw4iY2d6NFk/c5ecAvWzRpKPCz+kYCaI8vWxGAotHDeWa82IvmkSAhxImlkigZUgNMIVejg2i1Ednv3XAlBsN47GB4fBnHboEoMWFe2FQMa60wdAewnPZd9sytO6eEZTux+s3JpqMddlGwSuHqAJgMfgEx/dTbfpnfEqG8+Vu4F/JlHj99xs3WJxFXZ9yQ/L4QQt03nOhOQZ56DI7mWxpaTJRUUktge8M6nnKUzffmx8/OlqoD8idk5LLvGlkm5MuO5N/A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP/Va7sbIzrEiS03AfxwEoVMxBXRJq4EJKKfSbz05sI=;
 b=NHSKWVxCGfTuqN9NMkZdVRAl+Qr6M+ZGeOlhlhvUNfOTkB/hVH10iAYnXXlONKQC/1RcBxmPVIAkDZir2xWnK+8vMKX+HjO57UBt6pMNwHHam122dspVcF5yewhx+WPLHxV0zeLf+WBfhF2KGKpvBs4JUBjRlZp2XDuy8DVPf9PWX5WRGeVNGn5Hj4rYosMJDn9SpumGfs5jAUrjFGx4PK7uR29sSzMrFCjk0oLfG4wYqc5HSFX0agpwsmnt3n4m+WaII0D1wbd4v2GDh2GN8+dOy0c6VxuoppnyZahMJ1ZGKnpMkpYZw14HvSq5W2cY3q5oO/Nkcv4fP14kUHMk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5869.namprd11.prod.outlook.com (2603:10b6:303:168::9)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 01:08:27 +0000
Received: from MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::51ad:7054:17c6:c6e8]) by MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::51ad:7054:17c6:c6e8%5]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 01:08:27 +0000
From: "Herbert, Marc" <marc.herbert@intel.com>
To: Luc Van Oostenryck <lucvoo@kernel.org>
CC: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: Re: Infinite loop in delete_pseudo_user_list_entry() bisected to
 commit "cast: optimize away casts to/from pointers"
Thread-Topic: Infinite loop in delete_pseudo_user_list_entry() bisected to
 commit "cast: optimize away casts to/from pointers"
Thread-Index: AQHaOJgfUft6I+eAS0eEEBK7uDAAIbC8xEeAgAEIPQCAABb4AA==
Date: Thu, 28 Dec 2023 01:08:27 +0000
Message-ID: <4EB87136-D1B0-41CF-B552-9E9F19C00F3B@intel.com>
References: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
 <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>
 <xwsuvxor4dwmmabaf3f7acgo53rkjigtzxqfgdmlibkgejb2m3@ib6s5sn5njgv>
In-Reply-To: <xwsuvxor4dwmmabaf3f7acgo53rkjigtzxqfgdmlibkgejb2m3@ib6s5sn5njgv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5869:EE_|CH3PR11MB8519:EE_
x-ms-office365-filtering-correlation-id: d9cce0c7-c7dc-49b4-e67c-08dc07417f81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLGZ/oDEa9VdsQQL5+M8UfgZsLtHKAnwKM/oHaWu79hp7pJNZZqNx39Y1c2sng+J/sivUnMFfP4sFTqayt4wUzkQLjp0H2yFwl1RFhjhnDJwA31lCQImzPk7bKZWh9mPHP7gzroHDEzwXBh8+ARDDhmL3fKP0SXyr/ZYaH77zMndwMBUqBfjiUQr5lbGOQdKjVx1YzuYSe/N7AGeATAtz4hHOX1B+CwcPs43fPBJApnVK104+GT+apUjL3NNcAdfw8liHG4KkBitWrWpFy8EtJmvlYSXwxXJnAVN1qO/hrj0Zd1Fl5rez9hcC7HesDsrIrlkwt37WKOmcuTWeZNNyV0J6WHSC7gJEEK6SZi42KdzsZ/pclw3eUT5mtkWVsvll005zbuuu4rmodUr/HGD2g23rmnTh3o+kywCYA0CqDwhd3QoMvWm3KkkN5/YjizsiNo994u/l/ECagG5APZOJFTBZghRl0d0gZcdOKPbfco71GR4HAwhgWgqlmoE84eDRlC5HEUnUQRq4nktal8/IcX/Sl0DV4xgH4xa6eNFP+T1OGNCSMIP14gyjzYMMK5hRbYU6UgSuDc32jEDh7jFQGmoWzhtTEHYV0RwjU8lo8IBFpucsmaRG2KX98HRIv9qLSRJpI2LW7+kK9JKvjq+arM3IHGc0u1B3iQXTNUzJBLrb3yWi8j0hNx+u0Dz/+eq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(6486002)(71200400001)(966005)(478600001)(38070700009)(6506007)(6512007)(41300700001)(2616005)(82960400001)(86362001)(36756003)(33656002)(122000001)(38100700002)(83380400001)(26005)(4326008)(5660300002)(30864003)(2906002)(6916009)(8676002)(316002)(8936002)(76116006)(66946007)(66446008)(64756008)(66476007)(66556008)(45980500001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v/8Gk12lziaOpnFxQ3d+ZzYxoxo0bII3n3jmeyz23B30oLMjNxPJzNiUvMAI?=
 =?us-ascii?Q?sYV9Iwh42JvYttBbhsioWKbLYmOd3U1qeAPb930azhM7/u6A9GiPBj5b50rf?=
 =?us-ascii?Q?jDtWr00zqb1vFV/TmtGLWWoQwLI3JPFO1/6R+vUtGrHDBrYM7ovGIQi0KIjD?=
 =?us-ascii?Q?ERiKhGrDlUD7shEZlsOBQ3MUq7IMyMTNSHCMM5jWAoi0RBctMeBtFX6FAUDr?=
 =?us-ascii?Q?gXqupAyDBwhp5yhIL4L4gU9DvyUMu+v0mT7JbwEwvIwPpByufOOTT09PZhXP?=
 =?us-ascii?Q?5CYCWqHN8YDSFhmyaVjg7cch8+0Nust4HKAe15xZR81ihhmE2tDQvGyFP9CF?=
 =?us-ascii?Q?YqsHIrOBt53MJdFUCwZTijenpnhMCzEDpYAxa9K7J7WCjz6rjbPMKhzRyCn4?=
 =?us-ascii?Q?FQCe/unIINKVd/EEmFms13I0F/txyMH+nD3wz6nAvjkWwDqHcN1N2ekSYzvN?=
 =?us-ascii?Q?pRqu3Zc8ghF+PW87EGARd4ZimKxEs+Tfa3B9S3lOQh24jS38YUzM1L7YA+PF?=
 =?us-ascii?Q?f/K6xCLmJxOX6JwX4g9z6qKxf6EVCZ7BEvyUaxOmh+MNykuzTIw8pc9dPtir?=
 =?us-ascii?Q?uuy7qofyc7nY5NCIMavMZWH58or9BErvvgE39ehBVNFaqudro2SpfAjLm14T?=
 =?us-ascii?Q?MacUqv7b/oEHWpXethqZjmlyXjELkd07r0vzDqwy5qqU3LAhv7t9WFGWIq5y?=
 =?us-ascii?Q?XrBNc+j6FcJjAau5wCbuPOhGOkazT9DzsQuER98/AdAl+7lP2gpdvcaEl4Fm?=
 =?us-ascii?Q?i6U8B4b2ypR2bco6qgkyf3VJSffn9b6drWL3VlOIWbdOQEFqHRWbHdaTwzqv?=
 =?us-ascii?Q?q1bf4XS1GtBAyQzT08y7jk+mdKH3WiuKj0+hLKEMdVk4l6R+sDMM50PJW86m?=
 =?us-ascii?Q?/ysBfVBPa4u6DbqikSV81aAQl010t6JQOZgPa4ORbz9O3qvRXs8AhFO9ktzV?=
 =?us-ascii?Q?iHxhK4A4CLeTl62vm/QbTVMh8iRxypyChfF4BLqCfV+yAG0cBLf7qkxiI6Ee?=
 =?us-ascii?Q?6LyEF8pBfRFociofyso+Y4CjW7sdqVLkxsD9I27424Ar+Flrif7mI5nzAa/2?=
 =?us-ascii?Q?EDCw/vGBQd3bhGh3Djn8wLuxuJO1neTkLROdl794XfTGas7svEV9XSyUoKsS?=
 =?us-ascii?Q?W02s5OR0gvb5avMwB091bFFcssxqsMQHgcM87Bag2t0R7OW8/PofUu3WD7+a?=
 =?us-ascii?Q?d7Lt1cFNzEy7atIiy0iTLL8gNryUAInQkNdlfyA/D2MwIb9viTz4C3R7zDsB?=
 =?us-ascii?Q?QT8jGTG9cr8wOjlCDCfWmpLBpBmwXieqeJb5+KXx3mOLv2/0dvj68Xd3i3Wb?=
 =?us-ascii?Q?prAzc5ZtOjiUeo3FqkRGFZgT9eajDGtaejhIXUVC5OTRsrndiVMWhXgf6MC1?=
 =?us-ascii?Q?sMZBTIJZGbKtv2MEp9cyb7D0Vp7Ry2z/u2NGCdZFMLLPg5y35LmFtP7XPJdq?=
 =?us-ascii?Q?p+3Nl65eEaM+rNM/946fFMT+O1AsoFVCP7be67nA8J2zKDYwRRE8OEyY8Ruo?=
 =?us-ascii?Q?xyypO+jnGyF61RDiCKtq+vu2FhnAGp7TXoRyIUKBP72orJA63f/OUiTQ1QH4?=
 =?us-ascii?Q?pmGzXuj6mSBCPZP3kNSCiZsMCuWfgv4PY4pIY3ISME4OTpuhqiE3S49yg43I?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA7547390C1E714BB4F55383DA0909F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cce0c7-c7dc-49b4-e67c-08dc07417f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 01:08:27.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63ydEjkW6cd+/yeMpxQQDFnyg5vmRF/x8QGd3uFepW8/x8aZsMzACWG4UiljTtBTj3po7v3D+khoLDH6sOHCGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

Hi,

> I've some problems to reproduce this.

I understand; reproduction is easy but only if you've setup the entire
Zephyr environment. It's not complicated but it does take some time.

> Would it be possible to get the result of the preprocessing of the
> file tls.c ?

Funny enough, when using sparse the Zephyr build system prints the
command only AFTER sparse has run :-( Fortunately, copying the command
from `ps` worked! No evil environment variable required.

More good news: running `sparse tls.i` on this pre-processed file
reproduces instantly for me.

So see tls.i file below. In case my mailer mangled the file (I gave up
on plain text email a long time ago, sorry about that) I also attached
it to the issue:
  https://github.com/zephyrproject-rtos/zephyr/issues/63417
I doubt this list accepts attachments...

I can also create a bug at bugzilla.kernel.org if you prefer.

Marc


typedef long ptrdiff_t;
typedef unsigned long size_t;
typedef int wchar_t;
typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;
typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;
typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;
typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;
typedef long int __quad_t;
typedef unsigned long int __u_quad_t;
typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;
typedef int __daddr_t;
typedef int __key_t;
typedef int __clockid_t;
typedef void * __timer_t;
typedef long int __blksize_t;
typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;
typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;
typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;
typedef long int __fsword_t;
typedef long int __ssize_t;
typedef long int __syscall_slong_t;
typedef unsigned long int __syscall_ulong_t;
typedef __off64_t __loff_t;
typedef char *__caddr_t;
typedef long int __intptr_t;
typedef unsigned int __socklen_t;
typedef int __sig_atomic_t;
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
typedef __uint8_t uint8_t;
typedef __uint16_t uint16_t;
typedef __uint32_t uint32_t;
typedef __uint64_t uint64_t;
typedef __int_least8_t int_least8_t;
typedef __int_least16_t int_least16_t;
typedef __int_least32_t int_least32_t;
typedef __int_least64_t int_least64_t;
typedef __uint_least8_t uint_least8_t;
typedef __uint_least16_t uint_least16_t;
typedef __uint_least32_t uint_least32_t;
typedef __uint_least64_t uint_least64_t;
typedef signed char int_fast8_t;
typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
typedef unsigned char uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
typedef long int intptr_t;
typedef unsigned long int uintptr_t;
typedef __intmax_t intmax_t;
typedef __uintmax_t uintmax_t;
typedef union {
			long long thelonglong;
			long double thelongdouble;
			uintmax_t theuintmax_t;
			size_t thesize_t;
			uintptr_t theuintptr_t;
			void *thepvoid;
			void (*thepfunc)(void);
} z_max_align_t;
typedef long atomic_t;
typedef atomic_t atomic_val_t;
typedef void *atomic_ptr_t;
typedef atomic_ptr_t atomic_ptr_val_t;
static inline _Bool atomic_cas(atomic_t *target, atomic_val_t old_value,
			atomic_val_t new_value)
{
			return __atomic_compare_exchange_n(target, &old_value, new_value,
			0, 8,
			8);
}
static inline _Bool atomic_ptr_cas(atomic_ptr_t *target, atomic_ptr_val_t o=
ld_value,
			atomic_ptr_val_t new_value)
{
			return __atomic_compare_exchange_n(target, &old_value, new_value,
			0, 8,
			8);
}
static inline atomic_val_t atomic_add(atomic_t *target, atomic_val_t value)
{
			return __atomic_fetch_add(target, value, 8);
}
static inline atomic_val_t atomic_sub(atomic_t *target, atomic_val_t value)
{
			return __atomic_fetch_sub(target, value, 8);
}
static inline atomic_val_t atomic_inc(atomic_t *target)
{
			return atomic_add(target, 1);
}
static inline atomic_val_t atomic_dec(atomic_t *target)
{
			return atomic_sub(target, 1);
}
static inline atomic_val_t atomic_get(const atomic_t *target)
{
			return __atomic_load_n(target, 8);
}
static inline atomic_ptr_val_t atomic_ptr_get(const atomic_ptr_t *target)
{
			return __atomic_load_n(target, 8);
}
static inline atomic_val_t atomic_set(atomic_t *target, atomic_val_t value)
{
			return __atomic_exchange_n(target, value, 8);
}
static inline atomic_ptr_val_t atomic_ptr_set(atomic_ptr_t *target, atomic_=
ptr_val_t value)
{
			return __atomic_exchange_n(target, value, 8);
}
static inline atomic_val_t atomic_clear(atomic_t *target)
{
			return atomic_set(target, 0);
}
static inline atomic_ptr_val_t atomic_ptr_clear(atomic_ptr_t *target)
{
			return atomic_ptr_set(target, ((void *)0));
}
static inline atomic_val_t atomic_or(atomic_t *target, atomic_val_t value)
{
			return __atomic_fetch_or(target, value, 8);
}
static inline atomic_val_t atomic_xor(atomic_t *target, atomic_val_t value)
{
			return __atomic_fetch_xor(target, value, 8);
}
static inline atomic_val_t atomic_and(atomic_t *target, atomic_val_t value)
{
			return __atomic_fetch_and(target, value, 8);
}
static inline atomic_val_t atomic_nand(atomic_t *target, atomic_val_t value=
)
{
			return __atomic_fetch_nand(target, value, 8);
}
static inline _Bool atomic_test_bit(const atomic_t *target, int bit)
{
			atomic_val_t val =3D atomic_get(((target) + ((bit) / (sizeof(atomic_val_=
t) * 8))));
			return (1 & (val >> (bit & ((sizeof(atomic_val_t) * 8) - 1)))) !=3D 0;
}
static inline _Bool atomic_test_and_clear_bit(atomic_t *target, int bit)
{
			atomic_val_t mask =3D (1UL << ((unsigned long)(bit) & ((sizeof(atomic_va=
l_t) * 8) - 1U)));
			atomic_val_t old;
			old =3D atomic_and(((target) + ((bit) / (sizeof(atomic_val_t) * 8))), ~m=
ask);
			return (old & mask) !=3D 0;
}
static inline _Bool atomic_test_and_set_bit(atomic_t *target, int bit)
{
			atomic_val_t mask =3D (1UL << ((unsigned long)(bit) & ((sizeof(atomic_va=
l_t) * 8) - 1U)));
			atomic_val_t old;
			old =3D atomic_or(((target) + ((bit) / (sizeof(atomic_val_t) * 8))), mas=
k);
			return (old & mask) !=3D 0;
}
static inline void atomic_clear_bit(atomic_t *target, int bit)
{
			atomic_val_t mask =3D (1UL << ((unsigned long)(bit) & ((sizeof(atomic_va=
l_t) * 8) - 1U)));
			(void)atomic_and(((target) + ((bit) / (sizeof(atomic_val_t) * 8))), ~mas=
k);
}
static inline void atomic_set_bit(atomic_t *target, int bit)
{
			atomic_val_t mask =3D (1UL << ((unsigned long)(bit) & ((sizeof(atomic_va=
l_t) * 8) - 1U)));
			(void)atomic_or(((target) + ((bit) / (sizeof(atomic_val_t) * 8))), mask)=
;
}
static inline void atomic_set_bit_to(atomic_t *target, int bit, _Bool val)
{
			atomic_val_t mask =3D (1UL << ((unsigned long)(bit) & ((sizeof(atomic_va=
l_t) * 8) - 1U)));
			if (val) {
			(void)atomic_or(((target) + ((bit) / (sizeof(atomic_val_t) * 8))), mask)=
;
			} else {
			(void)atomic_and(((target) + ((bit) / (sizeof(atomic_val_t) * 8))), ~mas=
k);
			}
}
void __attribute__((format (printf, 1, 2))) assert_print(const char *fmt, .=
..);
static inline _Bool is_power_of_two(unsigned int x)
{
			return (((x) !=3D 0U) && (((x) & ((x) - 1U)) =3D=3D 0U));
}
static inline int64_t arithmetic_shift_right(int64_t value, uint8_t shift)
{
			int64_t sign_ext;
			if (shift =3D=3D 0U) {
			return value;
			}
			sign_ext =3D (value >> 63) & 1;
			sign_ext =3D -sign_ext;
			return (value >> shift) | (sign_ext << (64 - shift));
}
static inline void bytecpy(void *dst, const void *src, size_t size)
{
			size_t i;
			for (i =3D 0; i < size; ++i) {
			((volatile uint8_t *)dst)[i] =3D ((volatile const uint8_t *)src)[i];
			}
}
static inline void byteswp(void *a, void *b, size_t size)
{
			uint8_t t;
			uint8_t *aa =3D (uint8_t *)a;
			uint8_t *bb =3D (uint8_t *)b;
			for (; size > 0; --size) {
			t =3D *aa;
			*aa++ =3D *bb;
			*bb++ =3D t;
			}
}
int char2hex(char c, uint8_t *x);
int hex2char(uint8_t x, char *c);
size_t bin2hex(const uint8_t *buf, size_t buflen, char *hex, size_t hexlen)=
;
size_t hex2bin(const char *hex, size_t hexlen, uint8_t *buf, size_t buflen)=
;
static inline uint8_t bcd2bin(uint8_t bcd)
{
			return ((10 * (bcd >> 4)) + (bcd & 0x0F));
}
static inline uint8_t bin2bcd(uint8_t bin)
{
			return (((bin / 10) << 4) | (bin % 10));
}
uint8_t u8_to_dec(char *buf, uint8_t buflen, uint8_t value);
char *utf8_trunc(char *utf8_str);
char *utf8_lcpy(char *dst, const char *src, size_t n);
static inline int sys_clock_hw_cycles_per_sec_runtime_get(void);
static inline int z_impl_sys_clock_hw_cycles_per_sec_runtime_get(void)
{
			extern int z_clock_hw_cycles_per_sec;
			return z_clock_hw_cycles_per_sec;
}
typedef __builtin_va_list __gnuc_va_list;
typedef __gnuc_va_list va_list;
typedef uintptr_t (*_k_syscall_handler_t)(uintptr_t arg1, uintptr_t arg2,
			uintptr_t arg3, uintptr_t arg4,
			uintptr_t arg5, uintptr_t arg6,
			void *ssf);
static inline __attribute__((always_inline)) _Bool z_syscall_trap(void)
{
			_Bool ret =3D 0;
			return ret;
}
static inline _Bool k_is_user_context(void)
{
			return 0;
}
extern int z_impl_sys_clock_hw_cycles_per_sec_runtime_get(void);
static inline int sys_clock_hw_cycles_per_sec_runtime_get(void)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_sys_clock_hw_cycles_per_sec_runtime_get();
}
struct _dnode {
			union {
			struct _dnode *head;
			struct _dnode *next;
			};
			union {
			struct _dnode *tail;
			struct _dnode *prev;
			};
};
typedef struct _dnode sys_dlist_t;
typedef struct _dnode sys_dnode_t;
static inline void sys_dlist_init(sys_dlist_t *list)
{
			list->head =3D (sys_dnode_t *)list;
			list->tail =3D (sys_dnode_t *)list;
}
static inline void sys_dnode_init(sys_dnode_t *node)
{
			node->next =3D ((void *)0);
			node->prev =3D ((void *)0);
}
static inline _Bool sys_dnode_is_linked(const sys_dnode_t *node)
{
			return node->next !=3D ((void *)0);
}
static inline _Bool sys_dlist_is_head(sys_dlist_t *list, sys_dnode_t *node)
{
			return list->head =3D=3D node;
}
static inline _Bool sys_dlist_is_tail(sys_dlist_t *list, sys_dnode_t *node)
{
			return list->tail =3D=3D node;
}
static inline _Bool sys_dlist_is_empty(sys_dlist_t *list)
{
			return list->head =3D=3D list;
}
static inline _Bool sys_dlist_has_multiple_nodes(sys_dlist_t *list)
{
			return list->head !=3D list->tail;
}
static inline sys_dnode_t *sys_dlist_peek_head(sys_dlist_t *list)
{
			return sys_dlist_is_empty(list) ? ((void *)0) : list->head;
}
static inline sys_dnode_t *sys_dlist_peek_head_not_empty(sys_dlist_t *list)
{
			return list->head;
}
static inline sys_dnode_t *sys_dlist_peek_next_no_check(sys_dlist_t *list,
			sys_dnode_t *node)
{
			return (node =3D=3D list->tail) ? ((void *)0) : node->next;
}
static inline sys_dnode_t *sys_dlist_peek_next(sys_dlist_t *list,
			sys_dnode_t *node)
{
			return (node !=3D ((void *)0)) ? sys_dlist_peek_next_no_check(list, node=
) : ((void *)0);
}
static inline sys_dnode_t *sys_dlist_peek_prev_no_check(sys_dlist_t *list,
			sys_dnode_t *node)
{
			return (node =3D=3D list->head) ? ((void *)0) : node->prev;
}
static inline sys_dnode_t *sys_dlist_peek_prev(sys_dlist_t *list,
			sys_dnode_t *node)
{
			return (node !=3D ((void *)0)) ? sys_dlist_peek_prev_no_check(list, node=
) : ((void *)0);
}
static inline sys_dnode_t *sys_dlist_peek_tail(sys_dlist_t *list)
{
			return sys_dlist_is_empty(list) ? ((void *)0) : list->tail;
}
static inline void sys_dlist_append(sys_dlist_t *list, sys_dnode_t *node)
{
			sys_dnode_t *const tail =3D list->tail;
			node->next =3D list;
			node->prev =3D tail;
			tail->next =3D node;
			list->tail =3D node;
}
static inline void sys_dlist_prepend(sys_dlist_t *list, sys_dnode_t *node)
{
			sys_dnode_t *const head =3D list->head;
			node->next =3D head;
			node->prev =3D list;
			head->prev =3D node;
			list->head =3D node;
}
static inline void sys_dlist_insert(sys_dnode_t *successor, sys_dnode_t *no=
de)
{
			sys_dnode_t *const prev =3D successor->prev;
			node->prev =3D prev;
			node->next =3D successor;
			prev->next =3D node;
			successor->prev =3D node;
}
static inline void sys_dlist_insert_at(sys_dlist_t *list, sys_dnode_t *node=
,
			int (*cond)(sys_dnode_t *node, void *data), void *data)
{
			if (sys_dlist_is_empty(list)) {
			sys_dlist_append(list, node);
			} else {
			sys_dnode_t *pos =3D sys_dlist_peek_head(list);
			while ((pos !=3D ((void *)0)) && (cond(pos, data) =3D=3D 0)) {
			pos =3D sys_dlist_peek_next(list, pos);
			}
			if (pos !=3D ((void *)0)) {
			sys_dlist_insert(pos, node);
			} else {
			sys_dlist_append(list, node);
			}
			}
}
static inline void sys_dlist_remove(sys_dnode_t *node)
{
			sys_dnode_t *const prev =3D node->prev;
			sys_dnode_t *const next =3D node->next;
			prev->next =3D next;
			next->prev =3D prev;
			sys_dnode_init(node);
}
static inline sys_dnode_t *sys_dlist_get(sys_dlist_t *list)
{
			sys_dnode_t *node =3D ((void *)0);
			if (!sys_dlist_is_empty(list)) {
			node =3D list->head;
			sys_dlist_remove(node);
			}
			return node;
}
static inline size_t sys_dlist_len(sys_dlist_t *list)
{
			size_t len =3D 0;
			sys_dnode_t *node =3D ((void *)0);
			for (node =3D sys_dlist_peek_head(list); node !=3D ((void *)0); node =3D=
 sys_dlist_peek_next(list, node)) {
			len++;
			}
			return len;
}
struct rbnode {
			struct rbnode *children[2];
};
typedef _Bool (*rb_lessthan_t)(struct rbnode *a, struct rbnode *b);
struct rbtree {
			struct rbnode *root;
			rb_lessthan_t lessthan_fn;
			int max_depth;
};
typedef void (*rb_visit_t)(struct rbnode *node, void *cookie);
struct rbnode *z_rb_child(struct rbnode *node, uint8_t side);
int z_rb_is_black(struct rbnode *node);
void z_rb_walk(struct rbnode *node, rb_visit_t visit_fn, void *cookie);
struct rbnode *z_rb_get_minmax(struct rbtree *tree, uint8_t side);
void rb_insert(struct rbtree *tree, struct rbnode *node);
void rb_remove(struct rbtree *tree, struct rbnode *node);
static inline struct rbnode *rb_get_min(struct rbtree *tree)
{
			return z_rb_get_minmax(tree, 0U);
}
static inline struct rbnode *rb_get_max(struct rbtree *tree)
{
			return z_rb_get_minmax(tree, 1U);
}
_Bool rb_contains(struct rbtree *tree, struct rbnode *node);
static inline void rb_walk(struct rbtree *tree, rb_visit_t visit_fn,
			void *cookie)
{
			z_rb_walk(tree->root, visit_fn, cookie);
}
struct _rb_foreach {
			struct rbnode **stack;
			uint8_t *is_left;
			int32_t top;
};
struct rbnode *z_rb_foreach_next(struct rbtree *tree, struct _rb_foreach *f=
);
struct k_thread;
struct k_thread *z_priq_dumb_best(sys_dlist_t *pq);
void z_priq_dumb_remove(sys_dlist_t *pq, struct k_thread *thread);
struct _priq_rb {
			struct rbtree tree;
			int next_order_key;
};
void z_priq_rb_add(struct _priq_rb *pq, struct k_thread *thread);
void z_priq_rb_remove(struct _priq_rb *pq, struct k_thread *thread);
struct k_thread *z_priq_rb_best(struct _priq_rb *pq);
struct _priq_mq {
			sys_dlist_t queues[32];
			unsigned int bitmask;
};
struct k_thread *z_priq_mq_best(struct _priq_mq *pq);
struct _snode {
			struct _snode *next;
};
typedef struct _snode sys_snode_t;
struct _slist {
			sys_snode_t *head;
			sys_snode_t *tail;
};
typedef struct _slist sys_slist_t;
static inline void sys_slist_init(sys_slist_t *list)
{
			list->head =3D ((void *)0);
			list->tail =3D ((void *)0);
}
static inline sys_snode_t *z_snode_next_peek(sys_snode_t *node)
{
			return node->next;
}
static inline void z_snode_next_set(sys_snode_t *parent, sys_snode_t *child=
)
{
			parent->next =3D child;
}
static inline void z_slist_head_set(sys_slist_t *list, sys_snode_t *node)
{
			list->head =3D node;
}
static inline void z_slist_tail_set(sys_slist_t *list, sys_snode_t *node)
{
			list->tail =3D node;
}
static inline sys_snode_t *sys_slist_peek_head(sys_slist_t *list)
{
			return list->head;
}
static inline sys_snode_t *sys_slist_peek_tail(sys_slist_t *list)
{
			return list->tail;
}
static inline _Bool sys_slist_is_empty(sys_slist_t *list);
static inline _Bool sys_slist_is_empty(sys_slist_t *list) { return (sys_sli=
st_peek_head(list) =3D=3D ((void *)0)); }
static inline sys_snode_t *sys_slist_peek_next_no_check(sys_snode_t *node);
static inline sys_snode_t * sys_slist_peek_next_no_check(sys_snode_t *node)=
 { return z_snode_next_peek(node); }
static inline sys_snode_t *sys_slist_peek_next(sys_snode_t *node);
static inline sys_snode_t * sys_slist_peek_next(sys_snode_t *node) { return=
 node !=3D ((void *)0) ? sys_slist_peek_next_no_check(node) : ((void *)0); =
}
static inline void sys_slist_prepend(sys_slist_t *list,
			sys_snode_t *node);
static inline void sys_slist_prepend(sys_slist_t *list, sys_snode_t *node) =
{ z_snode_next_set(node, sys_slist_peek_head(list)); z_slist_head_set(list,=
 node); if (sys_slist_peek_tail(list) =3D=3D ((void *)0)) { z_slist_tail_se=
t(list, sys_slist_peek_head(list)); } }
static inline void sys_slist_append(sys_slist_t *list,
			sys_snode_t *node);
static inline void sys_slist_append(sys_slist_t *list, sys_snode_t *node) {=
 z_snode_next_set(node, ((void *)0)); if (sys_slist_peek_tail(list) =3D=3D =
((void *)0)) { z_slist_tail_set(list, node); z_slist_head_set(list, node); =
} else { z_snode_next_set( sys_slist_peek_tail(list), node); z_slist_tail_s=
et(list, node); } }
static inline void sys_slist_append_list(sys_slist_t *list,
			void *head, void *tail);
static inline void sys_slist_append_list(sys_slist_t *list, void *head, voi=
d *tail) { if (head !=3D ((void *)0) && tail !=3D ((void *)0)) { if (sys_sl=
ist_peek_tail(list) =3D=3D ((void *)0)) { z_slist_head_set(list, (sys_snode=
_t *)head); } else { z_snode_next_set( sys_slist_peek_tail(list), (sys_snod=
e_t *)head); } z_slist_tail_set(list, (sys_snode_t *)tail); } }
static inline void sys_slist_merge_slist(sys_slist_t *list,
			sys_slist_t *list_to_append);
static inline void sys_slist_merge_slist ( sys_slist_t *list, sys_slist_t *=
list_to_append) { sys_snode_t *head, *tail; head =3D sys_slist_peek_head(li=
st_to_append); tail =3D sys_slist_peek_tail(list_to_append); sys_slist_appe=
nd_list(list, head, tail); sys_slist_init(list_to_append); }
static inline void sys_slist_insert(sys_slist_t *list,
			sys_snode_t *prev,
			sys_snode_t *node);
static inline void sys_slist_insert(sys_slist_t *list, sys_snode_t *prev, s=
ys_snode_t *node) { if (prev =3D=3D ((void *)0)) { sys_slist_prepend(list, =
node); } else if (z_snode_next_peek(prev) =3D=3D ((void *)0)) { sys_slist_a=
ppend(list, node); } else { z_snode_next_set(node, z_snode_next_peek(prev))=
; z_snode_next_set(prev, node); } }
static inline sys_snode_t *sys_slist_get_not_empty(sys_slist_t *list);
static inline sys_snode_t * sys_slist_get_not_empty(sys_slist_t *list) { sy=
s_snode_t *node =3D sys_slist_peek_head(list); z_slist_head_set(list, z_sno=
de_next_peek(node)); if (sys_slist_peek_tail(list) =3D=3D node) { z_slist_t=
ail_set(list, sys_slist_peek_head(list)); } return node; }
static inline sys_snode_t *sys_slist_get(sys_slist_t *list);
static inline sys_snode_t * sys_slist_get(sys_slist_t *list) { return sys_s=
list_is_empty(list) ? ((void *)0) : sys_slist_get_not_empty(list); }
static inline void sys_slist_remove(sys_slist_t *list,
			sys_snode_t *prev_node,
			sys_snode_t *node);
static inline void sys_slist_remove(sys_slist_t *list, sys_snode_t *prev_no=
de, sys_snode_t *node) { if (prev_node =3D=3D ((void *)0)) { z_slist_head_s=
et(list, z_snode_next_peek(node)); if (sys_slist_peek_tail(list) =3D=3D nod=
e) { z_slist_tail_set(list, sys_slist_peek_head(list)); } } else { z_snode_=
next_set(prev_node, z_snode_next_peek(node)); if (sys_slist_peek_tail(list)=
 =3D=3D node) { z_slist_tail_set(list, prev_node); } } z_snode_next_set(nod=
e, ((void *)0)); }
static inline _Bool sys_slist_find_and_remove(sys_slist_t *list,
			sys_snode_t *node);
static inline size_t sys_slist_len(sys_slist_t *list);
static inline size_t sys_slist_len(sys_slist_t * list) { size_t len =3D 0; =
static sys_snode_t * node; for (node =3D sys_slist_peek_head(list); node !=
=3D ((void *)0); node =3D sys_slist_peek_next(node)) { len++; } return len;=
 }
static inline _Bool sys_slist_find_and_remove(sys_slist_t *list, sys_snode_=
t *node) { sys_snode_t *prev =3D ((void *)0); sys_snode_t *test; for (test =
=3D sys_slist_peek_head(list); test !=3D ((void *)0); test =3D sys_slist_pe=
ek_next(test)) { if (test =3D=3D node) { sys_slist_remove(list, prev, node)=
; return 1; } prev =3D test; } return 0; }
typedef uint64_t unative_t;
struct _sfnode {
			unative_t next_and_flags;
};
typedef struct _sfnode sys_sfnode_t;
struct _sflist {
			sys_sfnode_t *head;
			sys_sfnode_t *tail;
};
typedef struct _sflist sys_sflist_t;
static inline void sys_sflist_init(sys_sflist_t *list)
{
			list->head =3D ((void *)0);
			list->tail =3D ((void *)0);
}
static inline sys_sfnode_t *z_sfnode_next_peek(sys_sfnode_t *node)
{
			return (sys_sfnode_t *)(node->next_and_flags & ~0x3UL);
}
static inline uint8_t sys_sfnode_flags_get(sys_sfnode_t *node);
static inline void z_sfnode_next_set(sys_sfnode_t *parent,
			sys_sfnode_t *child)
{
			uint8_t cur_flags =3D sys_sfnode_flags_get(parent);
			parent->next_and_flags =3D cur_flags | (unative_t)child;
}
static inline void z_sflist_head_set(sys_sflist_t *list, sys_sfnode_t *node=
)
{
			list->head =3D node;
}
static inline void z_sflist_tail_set(sys_sflist_t *list, sys_sfnode_t *node=
)
{
			list->tail =3D node;
}
static inline sys_sfnode_t *sys_sflist_peek_head(sys_sflist_t *list)
{
			return list->head;
}
static inline sys_sfnode_t *sys_sflist_peek_tail(sys_sflist_t *list)
{
			return list->tail;
}
static inline uint8_t sys_sfnode_flags_get(sys_sfnode_t *node)
{
			return node->next_and_flags & 0x3UL;
}
static inline void sys_sfnode_init(sys_sfnode_t *node, uint8_t flags)
{
			{ };
			node->next_and_flags =3D flags;
}
static inline void sys_sfnode_flags_set(sys_sfnode_t *node, uint8_t flags)
{
			{ };
			node->next_and_flags =3D (unative_t)(z_sfnode_next_peek(node)) | flags;
}
static inline _Bool sys_sflist_is_empty(sys_sflist_t *list);
static inline _Bool sys_sflist_is_empty(sys_sflist_t *list) { return (sys_s=
flist_peek_head(list) =3D=3D ((void *)0)); }
static inline sys_sfnode_t *sys_sflist_peek_next_no_check(sys_sfnode_t *nod=
e);
static inline sys_sfnode_t * sys_sflist_peek_next_no_check(sys_sfnode_t *no=
de) { return z_sfnode_next_peek(node); }
static inline sys_sfnode_t *sys_sflist_peek_next(sys_sfnode_t *node);
static inline sys_sfnode_t * sys_sflist_peek_next(sys_sfnode_t *node) { ret=
urn node !=3D ((void *)0) ? sys_sflist_peek_next_no_check(node) : ((void *)=
0); }
static inline void sys_sflist_prepend(sys_sflist_t *list,
			sys_sfnode_t *node);
static inline void sys_sflist_prepend(sys_sflist_t *list, sys_sfnode_t *nod=
e) { z_sfnode_next_set(node, sys_sflist_peek_head(list)); z_sflist_head_set=
(list, node); if (sys_sflist_peek_tail(list) =3D=3D ((void *)0)) { z_sflist=
_tail_set(list, sys_sflist_peek_head(list)); } }
static inline void sys_sflist_append(sys_sflist_t *list,
			sys_sfnode_t *node);
static inline void sys_sflist_append(sys_sflist_t *list, sys_sfnode_t *node=
) { z_sfnode_next_set(node, ((void *)0)); if (sys_sflist_peek_tail(list) =
=3D=3D ((void *)0)) { z_sflist_tail_set(list, node); z_sflist_head_set(list=
, node); } else { z_sfnode_next_set( sys_sflist_peek_tail(list), node); z_s=
flist_tail_set(list, node); } }
static inline void sys_sflist_append_list(sys_sflist_t *list,
			void *head, void *tail);
static inline void sys_sflist_append_list(sys_sflist_t *list, void *head, v=
oid *tail) { if (head !=3D ((void *)0) && tail !=3D ((void *)0)) { if (sys_=
sflist_peek_tail(list) =3D=3D ((void *)0)) { z_sflist_head_set(list, (sys_s=
fnode_t *)head); } else { z_sfnode_next_set( sys_sflist_peek_tail(list), (s=
ys_sfnode_t *)head); } z_sflist_tail_set(list, (sys_sfnode_t *)tail); } }
static inline void sys_sflist_merge_sflist(sys_sflist_t *list,
			sys_sflist_t *list_to_append);
static inline void sys_sflist_merge_sflist ( sys_sflist_t *list, sys_sflist=
_t *list_to_append) { sys_sfnode_t *head, *tail; head =3D sys_sflist_peek_h=
ead(list_to_append); tail =3D sys_sflist_peek_tail(list_to_append); sys_sfl=
ist_append_list(list, head, tail); sys_sflist_init(list_to_append); }
static inline void sys_sflist_insert(sys_sflist_t *list,
			sys_sfnode_t *prev,
			sys_sfnode_t *node);
static inline void sys_sflist_insert(sys_sflist_t *list, sys_sfnode_t *prev=
, sys_sfnode_t *node) { if (prev =3D=3D ((void *)0)) { sys_sflist_prepend(l=
ist, node); } else if (z_sfnode_next_peek(prev) =3D=3D ((void *)0)) { sys_s=
flist_append(list, node); } else { z_sfnode_next_set(node, z_sfnode_next_pe=
ek(prev)); z_sfnode_next_set(prev, node); } }
static inline sys_sfnode_t *sys_sflist_get_not_empty(sys_sflist_t *list);
static inline sys_sfnode_t * sys_sflist_get_not_empty(sys_sflist_t *list) {=
 sys_sfnode_t *node =3D sys_sflist_peek_head(list); z_sflist_head_set(list,=
 z_sfnode_next_peek(node)); if (sys_sflist_peek_tail(list) =3D=3D node) { z=
_sflist_tail_set(list, sys_sflist_peek_head(list)); } return node; }
static inline sys_sfnode_t *sys_sflist_get(sys_sflist_t *list);
static inline sys_sfnode_t * sys_sflist_get(sys_sflist_t *list) { return sy=
s_sflist_is_empty(list) ? ((void *)0) : sys_sflist_get_not_empty(list); }
static inline void sys_sflist_remove(sys_sflist_t *list,
			sys_sfnode_t *prev_node,
			sys_sfnode_t *node);
static inline void sys_sflist_remove(sys_sflist_t *list, sys_sfnode_t *prev=
_node, sys_sfnode_t *node) { if (prev_node =3D=3D ((void *)0)) { z_sflist_h=
ead_set(list, z_sfnode_next_peek(node)); if (sys_sflist_peek_tail(list) =3D=
=3D node) { z_sflist_tail_set(list, sys_sflist_peek_head(list)); } } else {=
 z_sfnode_next_set(prev_node, z_sfnode_next_peek(node)); if (sys_sflist_pee=
k_tail(list) =3D=3D node) { z_sflist_tail_set(list, prev_node); } } z_sfnod=
e_next_set(node, ((void *)0)); }
static inline _Bool sys_sflist_find_and_remove(sys_sflist_t *list,
			sys_sfnode_t *node);
static inline _Bool sys_sflist_find_and_remove(sys_sflist_t *list, sys_sfno=
de_t *node) { sys_sfnode_t *prev =3D ((void *)0); sys_sfnode_t *test; for (=
test =3D sys_sflist_peek_head(list); test !=3D ((void *)0); test =3D sys_sf=
list_peek_next(test)) { if (test =3D=3D node) { sys_sflist_remove(list, pre=
v, node); return 1; } prev =3D test; } return 0; }
static inline size_t sys_sflist_len(sys_sflist_t *list);
static inline size_t sys_sflist_len(sys_sflist_t * list) { size_t len =3D 0=
; static sys_sfnode_t * node; for (node =3D sys_sflist_peek_head(list); nod=
e !=3D ((void *)0); node =3D sys_sflist_peek_next(node)) { len++; } return =
len; }
struct k_obj_type;
struct k_obj_core;
extern sys_slist_t z_obj_type_list;
struct k_obj_core_stats_desc {
			size_t raw_size;
			size_t query_size;
			int (*raw)(struct k_obj_core *obj_core, void *stats);
			int (*query)(struct k_obj_core *obj_core, void *stats);
			int (*reset)(struct k_obj_core *obj_core);
			int (*disable)(struct k_obj_core *obj_core);
			int (*enable)(struct k_obj_core *obj_core);
};
struct k_obj_type {
			sys_snode_t node;
			sys_slist_t list;
			uint32_t id;
			size_t obj_core_offset;
};
struct k_obj_core {
			sys_snode_t node;
			struct k_obj_type *type;
};
struct k_obj_type *z_obj_type_init(struct k_obj_type *type,
			uint32_t id, size_t off);
struct k_obj_type *k_obj_type_find(uint32_t type_id);
int k_obj_type_walk_locked(struct k_obj_type *type,
			int (*func)(struct k_obj_core *, void *),
			void *data);
int k_obj_type_walk_unlocked(struct k_obj_type *type,
			int (*func)(struct k_obj_core *, void *),
			void *data);
void k_obj_core_init(struct k_obj_core *obj_core, struct k_obj_type *type);
void k_obj_core_link(struct k_obj_core *obj_core);
void k_obj_core_init_and_link(struct k_obj_core *obj_core,
			struct k_obj_type *type);
void k_obj_core_unlink(struct k_obj_core *obj_core);
int k_obj_core_stats_register(struct k_obj_core *obj_core, void *stats,
			size_t stats_len);
int k_obj_core_stats_deregister(struct k_obj_core *obj_core);
int k_obj_core_stats_raw(struct k_obj_core *obj_core, void *stats,
			size_t stats_len);
int k_obj_core_stats_query(struct k_obj_core *obj_core, void *stats,
			size_t stats_len);
int k_obj_core_stats_reset(struct k_obj_core *obj_core);
int k_obj_core_stats_disable(struct k_obj_core *obj_core);
int k_obj_core_stats_enable(struct k_obj_core *obj_core);
struct sys_memory_stats {
			size_t free_bytes;
			size_t allocated_bytes;
			size_t max_allocated_bytes;
};
struct sys_heap {
			struct z_heap *heap;
			void *init_mem;
			size_t init_bytes;
};
struct z_heap_stress_result {
			uint32_t total_allocs;
			uint32_t successful_allocs;
			uint32_t total_frees;
			uint64_t accumulated_in_use_bytes;
};
void sys_heap_init(struct sys_heap *heap, void *mem, size_t bytes);
void *sys_heap_alloc(struct sys_heap *heap, size_t bytes);
void *sys_heap_aligned_alloc(struct sys_heap *heap, size_t align, size_t by=
tes);
void sys_heap_free(struct sys_heap *heap, void *mem);
void *sys_heap_aligned_realloc(struct sys_heap *heap, void *ptr,
			size_t align, size_t bytes);
size_t sys_heap_usable_size(struct sys_heap *heap, void *mem);
_Bool sys_heap_validate(struct sys_heap *heap);
void sys_heap_stress(void *(*alloc_fn)(void *arg, size_t bytes),
			void (*free_fn)(void *arg, void *p),
			void *arg, size_t total_bytes,
			uint32_t op_count,
			void *scratch_mem, size_t scratch_bytes,
			int target_percent,
			struct z_heap_stress_result *result);
void sys_heap_print_info(struct sys_heap *heap, _Bool dump_chunks);
struct _cpu_arch {
			atomic_ptr_val_t fpu_owner;
};
typedef struct _cpu_arch _cpu_arch_t;
struct k_cycle_stats {
			uint64_t total;
			_Bool track_usage;
};
struct _ready_q {
			struct k_thread *cache;
			sys_dlist_t runq;
};
typedef struct _ready_q _ready_q_t;
struct _cpu {
			uint32_t nested;
			char *irq_stack;
			struct k_thread *current;
			struct k_thread *idle_thread;
			uint8_t id;
			void *fp_ctx;
			struct _cpu_arch arch;
};
typedef struct _cpu _cpu_t;
struct z_kernel {
			struct _cpu cpus[1];
			struct _ready_q ready_q;
			struct k_thread *current_fp;
};
typedef struct z_kernel _kernel_t;
extern struct z_kernel _kernel;
extern atomic_t _cpus_active;
typedef struct {
			sys_dlist_t waitq;
} _wait_q_t;
struct _timeout;
typedef void (*_timeout_func_t)(struct _timeout *t);
struct _timeout {
			sys_dnode_t node;
			_timeout_func_t fn;
			int64_t dticks;
};
typedef void (*k_thread_timeslice_fn_t)(struct k_thread *thread, void *data=
);
uint32_t sys_kernel_version_get(void);
typedef int __gwchar_t;
typedef struct
		{
			long int quot;
			long int rem;
		} imaxdiv_t;
extern intmax_t imaxabs (intmax_t __n) __attribute__ ((__nothrow__ , __leaf=
__)) __attribute__ ((__const__));
extern imaxdiv_t imaxdiv (intmax_t __numer, intmax_t __denom)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern intmax_t strtoimax (const char *__restrict __nptr,
			char **__restrict __endptr, int __base) __attribute__ ((__nothrow__ , __=
leaf__));
extern uintmax_t strtoumax (const char *__restrict __nptr,
			char ** __restrict __endptr, int __base) __attribute__ ((__nothrow__ , _=
_leaf__));
extern intmax_t wcstoimax (const __gwchar_t *__restrict __nptr,
			__gwchar_t **__restrict __endptr, int __base)
			__attribute__ ((__nothrow__ , __leaf__));
extern uintmax_t wcstoumax (const __gwchar_t *__restrict __nptr,
			__gwchar_t ** __restrict __endptr, int __base)
			__attribute__ ((__nothrow__ , __leaf__));
__attribute__((format (printf, 1, 2))) void printk(const char *fmt, ...);
__attribute__((format (printf, 1, 0))) void vprintk(const char *fmt, va_lis=
t ap);
typedef struct
{
		int __count;
		union
		{
			unsigned int __wch;
			char __wchb[4];
		} __value;
} __mbstate_t;
typedef struct _G_fpos_t
{
		__off_t __pos;
		__mbstate_t __state;
} __fpos_t;
typedef struct _G_fpos64_t
{
		__off64_t __pos;
		__mbstate_t __state;
} __fpos64_t;
struct _IO_FILE;
typedef struct _IO_FILE __FILE;
struct _IO_FILE;
typedef struct _IO_FILE FILE;
struct _IO_FILE;
struct _IO_marker;
struct _IO_codecvt;
struct _IO_wide_data;
typedef void _IO_lock_t;
struct _IO_FILE
{
		int _flags;
		char *_IO_read_ptr;
		char *_IO_read_end;
		char *_IO_read_base;
		char *_IO_write_base;
		char *_IO_write_ptr;
		char *_IO_write_end;
		char *_IO_buf_base;
		char *_IO_buf_end;
		char *_IO_save_base;
		char *_IO_backup_base;
		char *_IO_save_end;
		struct _IO_marker *_markers;
		struct _IO_FILE *_chain;
		int _fileno;
		int _flags2;
		__off_t _old_offset;
		unsigned short _cur_column;
		signed char _vtable_offset;
		char _shortbuf[1];
		_IO_lock_t *_lock;
		__off64_t _offset;
		struct _IO_codecvt *_codecvt;
		struct _IO_wide_data *_wide_data;
		struct _IO_FILE *_freeres_list;
		void *_freeres_buf;
		size_t __pad5;
		int _mode;
		char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];
};
typedef __off_t off_t;
typedef __ssize_t ssize_t;
typedef __fpos_t fpos_t;
extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;
extern int remove (const char *__filename) __attribute__ ((__nothrow__ , __=
leaf__));
extern int rename (const char *__old, const char *__new) __attribute__ ((__=
nothrow__ , __leaf__));
extern int renameat (int __oldfd, const char *__old, int __newfd,
			const char *__new) __attribute__ ((__nothrow__ , __leaf__));
extern int fclose (FILE *__stream) __attribute__ ((__nonnull__ (1)));
extern FILE *tmpfile (void)
		__attribute__ ((__malloc__)) __attribute__ ((__malloc__ (fclose, 1))) __a=
ttribute__ ((__warn_unused_result__));
extern char *tmpnam (char[20]) __attribute__ ((__nothrow__ , __leaf__)) __a=
ttribute__ ((__warn_unused_result__));
extern int fflush (FILE *__stream);
extern FILE *fopen (const char *__restrict __filename,
			const char *__restrict __modes)
		__attribute__ ((__malloc__)) __attribute__ ((__malloc__ (fclose, 1))) __a=
ttribute__ ((__warn_unused_result__));
extern FILE *freopen (const char *__restrict __filename,
			const char *__restrict __modes,
			FILE *__restrict __stream) __attribute__ ((__warn_unused_result__)) __at=
tribute__ ((__nonnull__ (3)));
extern FILE *fdopen (int __fd, const char *__modes) __attribute__ ((__nothr=
ow__ , __leaf__))
		__attribute__ ((__malloc__)) __attribute__ ((__malloc__ (fclose, 1))) __a=
ttribute__ ((__warn_unused_result__));
extern FILE *fmemopen (void *__s, size_t __len, const char *__modes)
		__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __a=
ttribute__ ((__malloc__ (fclose, 1))) __attribute__ ((__warn_unused_result_=
_));
extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribut=
e__ ((__nothrow__ , __leaf__))
		__attribute__ ((__malloc__)) __attribute__ ((__malloc__ (fclose, 1))) __a=
ttribute__ ((__warn_unused_result__));
extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __at=
tribute__ ((__nothrow__ , __leaf__));
extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
			int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));
extern int fprintf (FILE *__restrict __stream,
			const char *__restrict __format, ...);
extern int printf (const char *__restrict __format, ...);
extern int sprintf (char *__restrict __s,
			const char *__restrict __format, ...) __attribute__ ((__nothrow__));
extern int vfprintf (FILE *__restrict __s, const char *__restrict __format,
			__gnuc_va_list __arg);
extern int vprintf (const char *__restrict __format, __gnuc_va_list __arg);
extern int vsprintf (char *__restrict __s, const char *__restrict __format,
			__gnuc_va_list __arg) __attribute__ ((__nothrow__));
extern int snprintf (char *__restrict __s, size_t __maxlen,
			const char *__restrict __format, ...)
			__attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3,=
 4)));
extern int vsnprintf (char *__restrict __s, size_t __maxlen,
			const char *__restrict __format, __gnuc_va_list __arg)
			__attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3,=
 0)));
extern int vdprintf (int __fd, const char *__restrict __fmt,
			__gnuc_va_list __arg)
			__attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, const char *__restrict __fmt, ...)
			__attribute__ ((__format__ (__printf__, 2, 3)));
extern int fscanf (FILE *__restrict __stream,
			const char *__restrict __format, ...) __attribute__ ((__warn_unused_resu=
lt__));
extern int scanf (const char *__restrict __format, ...) __attribute__ ((__w=
arn_unused_result__));
extern int sscanf (const char *__restrict __s,
			const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __le=
af__));
extern int fscanf (FILE *__restrict __stream, const char *__restrict __form=
at, ...) __asm__ ("__USER_LABEL_PREFIX__" "__isoc99_fscanf") __attribute__ =
((__warn_unused_result__));
extern int scanf (const char *__restrict __format, ...) __asm__ ("__USER_LA=
BEL_PREFIX__" "__isoc99_scanf") __attribute__ ((__warn_unused_result__));
extern int sscanf (const char *__restrict __s, const char *__restrict __for=
mat, ...) __asm__ ("__USER_LABEL_PREFIX__" "__isoc99_sscanf") __attribute__=
 ((__nothrow__ , __leaf__));
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format,
			__gnuc_va_list __arg)
			__attribute__ ((__format__ (__scanf__, 2, 0))) __attribute__ ((__warn_un=
used_result__));
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg)
			__attribute__ ((__format__ (__scanf__, 1, 0))) __attribute__ ((__warn_un=
used_result__));
extern int vsscanf (const char *__restrict __s,
			const char *__restrict __format, __gnuc_va_list __arg)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__s=
canf__, 2, 0)));
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format, =
__gnuc_va_list __arg) __asm__ ("__USER_LABEL_PREFIX__" "__isoc99_vfscanf")
			__attribute__ ((__format__ (__scanf__, 2, 0))) __attribute__ ((__warn_un=
used_result__));
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg) _=
_asm__ ("__USER_LABEL_PREFIX__" "__isoc99_vscanf")
			__attribute__ ((__format__ (__scanf__, 1, 0))) __attribute__ ((__warn_un=
used_result__));
extern int vsscanf (const char *__restrict __s, const char *__restrict __fo=
rmat, __gnuc_va_list __arg) __asm__ ("__USER_LABEL_PREFIX__" "__isoc99_vssc=
anf") __attribute__ ((__nothrow__ , __leaf__))
			__attribute__ ((__format__ (__scanf__, 2, 0)));
extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);
extern int getchar (void);
extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);
extern int putchar (int __c);
extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);
extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __strea=
m)
			__attribute__ ((__warn_unused_result__)) __attribute__ ((__access__ (__w=
rite_only__, 1, 2)));
extern char *gets (char *__s) __attribute__ ((__warn_unused_result__)) __at=
tribute__ ((__deprecated__));
extern __ssize_t __getdelim (char **__restrict __lineptr,
			size_t *__restrict __n, int __delimiter,
			FILE *__restrict __stream) __attribute__ ((__warn_unused_result__));
extern __ssize_t getdelim (char **__restrict __lineptr,
			size_t *__restrict __n, int __delimiter,
			FILE *__restrict __stream) __attribute__ ((__warn_unused_result__));
extern __ssize_t getline (char **__restrict __lineptr,
			size_t *__restrict __n,
			FILE *__restrict __stream) __attribute__ ((__warn_unused_result__));
extern int fputs (const char *__restrict __s, FILE *__restrict __stream);
extern int puts (const char *__s);
extern int ungetc (int __c, FILE *__stream);
extern size_t fread (void *__restrict __ptr, size_t __size,
			size_t __n, FILE *__restrict __stream) __attribute__ ((__warn_unused_res=
ult__));
extern size_t fwrite (const void *__restrict __ptr, size_t __size,
			size_t __n, FILE *__restrict __s);
extern int fseek (FILE *__stream, long int __off, int __whence);
extern long int ftell (FILE *__stream) __attribute__ ((__warn_unused_result=
__));
extern void rewind (FILE *__stream);
extern int fseeko (FILE *__stream, __off_t __off, int __whence);
extern __off_t ftello (FILE *__stream) __attribute__ ((__warn_unused_result=
__));
extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);
extern int fsetpos (FILE *__stream, const fpos_t *__pos);
extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf_=
_));
extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) _=
_attribute__ ((__warn_unused_result__));
extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__))=
 __attribute__ ((__warn_unused_result__));
extern void perror (const char *__s) __attribute__ ((__cold__));
extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__))=
 __attribute__ ((__warn_unused_result__));
extern int pclose (FILE *__stream);
extern FILE *popen (const char *__command, const char *__modes)
		__attribute__ ((__malloc__)) __attribute__ ((__malloc__ (pclose, 1))) __a=
ttribute__ ((__warn_unused_result__));
extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__))
		__attribute__ ((__access__ (__write_only__, 1)));
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf=
__));
extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __le=
af__)) __attribute__ ((__warn_unused_result__));
extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __le=
af__));
extern int __uflow (FILE *);
extern int __overflow (FILE *, int);
extern int __sprintf_chk (char *__restrict __s, int __flag, size_t __slen,
			const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __le=
af__))
			__attribute__ ((__access__ (__write_only__, 1, 3)));
extern int __vsprintf_chk (char *__restrict __s, int __flag, size_t __slen,
			const char *__restrict __format,
			__gnuc_va_list __ap) __attribute__ ((__nothrow__ , __leaf__))
			__attribute__ ((__access__ (__write_only__, 1, 3)));
extern int __snprintf_chk (char *__restrict __s, size_t __n, int __flag,
			size_t __slen, const char *__restrict __format,
			...) __attribute__ ((__nothrow__ , __leaf__))
			__attribute__ ((__access__ (__write_only__, 1, 2)));
extern int __vsnprintf_chk (char *__restrict __s, size_t __n, int __flag,
			size_t __slen, const char *__restrict __format,
			__gnuc_va_list __ap) __attribute__ ((__nothrow__ , __leaf__))
			__attribute__ ((__access__ (__write_only__, 1, 2)));
extern char *__gets_warn (char *__str) __asm__ ("__USER_LABEL_PREFIX__" "ge=
ts")
			__attribute__ ((__warn_unused_result__)) __attribute__((__warning__ ("pl=
ease use fgets or getline instead, gets can't " "specify buffer size")));
extern char *__gets_chk (char *__str, size_t) __attribute__ ((__warn_unused=
_result__));
extern char *__fgets_alias (char *__restrict __s, int __n, FILE *__restrict=
 __stream) __asm__ ("__USER_LABEL_PREFIX__" "fgets")
			__attribute__ ((__warn_unused_result__)) __attribute__ ((__access__ (__w=
rite_only__, 1, 2)));
extern char *__fgets_chk_warn (char *__restrict __s, size_t __size, int __n=
, FILE *__restrict __stream) __asm__ ("__USER_LABEL_PREFIX__" "__fgets_chk"=
)
			__attribute__ ((__warn_unused_result__)) __attribute__((__warning__ ("fg=
ets called with bigger size than length " "of destination buffer")));
extern char *__fgets_chk (char *__restrict __s, size_t __size, int __n,
			FILE *__restrict __stream)
			__attribute__ ((__warn_unused_result__)) __attribute__ ((__access__ (__w=
rite_only__, 1, 3)));
extern size_t __fread_alias (void *__restrict __ptr, size_t __size, size_t =
__n, FILE *__restrict __stream) __asm__ ("__USER_LABEL_PREFIX__" "fread") _=
_attribute__ ((__warn_unused_result__));
extern size_t __fread_chk_warn (void *__restrict __ptr, size_t __ptrlen, si=
ze_t __size, size_t __n, FILE *__restrict __stream) __asm__ ("__USER_LABEL_=
PREFIX__" "__fread_chk")
			__attribute__ ((__warn_unused_result__)) __attribute__((__warning__ ("fr=
ead called with bigger size * nmemb than length " "of destination buffer"))=
);
extern size_t __fread_chk (void *__restrict __ptr, size_t __ptrlen,
			size_t __size, size_t __n,
			FILE *__restrict __stream) __attribute__ ((__warn_unused_result__));
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) int
__attribute__ ((__nothrow__ , __leaf__)) sprintf (char *__restrict __s, con=
st char *__restrict __fmt, ...)
{
		return __builtin___sprintf_chk (__s, 1 - 1,
			__builtin_object_size (__s, 1 > 1), __fmt,);
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) int
__attribute__ ((__nothrow__ , __leaf__)) vsprintf (char *__restrict __s, co=
nst char *__restrict __fmt, __gnuc_va_list __ap)
{
		return __builtin___vsprintf_chk (__s, 1 - 1,
			__builtin_object_size (__s, 1 > 1), __fmt, __ap);
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) int
__attribute__ ((__nothrow__ , __leaf__)) snprintf (char *__restrict __s, si=
ze_t __n, const char *__restrict __fmt, ...)
{
		return __builtin___snprintf_chk (__s, __n, 1 - 1,
			__builtin_object_size (__s, 1 > 1), __fmt,);
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) int
__attribute__ ((__nothrow__ , __leaf__)) vsnprintf (char *__restrict __s, s=
ize_t __n, const char *__restrict __fmt, __gnuc_va_list __ap)
{
		return __builtin___vsnprintf_chk (__s, __n, 1 - 1,
			__builtin_object_size (__s, 1 > 1), __fmt, __ap);
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) __attribute__ ((__warn_unused_result__)) char *
gets (char *__str)
{
		if (__builtin_object_size (__str, 1 > 1) !=3D (size_t) -1)
			return __gets_chk (__str, __builtin_object_size (__str, 1 > 1));
		return __gets_warn (__str);
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) __attribute__ ((__warn_unused_result__)) __attribute__ ((__access=
__ (__write_only__, 1, 2))) char *
fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
{
		size_t sz =3D __builtin_object_size (__s, 1 > 1);
		if (((__builtin_constant_p (sz) && (sz) =3D=3D (unsigned long) -1) || (((=
__typeof (__n)) 0 < (__typeof (__n)) -1 || (__builtin_constant_p (__n) && (=
__n) > 0)) && __builtin_constant_p ((((unsigned long) (__n)) <=3D ((sz)) / =
((sizeof (char))))) && (((unsigned long) (__n)) <=3D ((sz)) / ((sizeof (cha=
r)))))))
			return __fgets_alias (__s, __n, __stream);
		if ((((__typeof (__n)) 0 < (__typeof (__n)) -1 || (__builtin_constant_p (=
__n) && (__n) > 0)) && __builtin_constant_p ((((unsigned long) (__n)) <=3D =
(sz) / (sizeof (char)))) && !(((unsigned long) (__n)) <=3D (sz) / (sizeof (=
char)))))
			return __fgets_chk_warn (__s, sz, __n, __stream);
		return __fgets_chk (__s, sz, __n, __stream);
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) __attribute__ ((__warn_unused_result__)) size_t
fread (void *__restrict __ptr, size_t __size, size_t __n,
			FILE *__restrict __stream)
{
		size_t sz =3D __builtin_object_size (__ptr, 0);
		if (((__builtin_constant_p (sz) && (sz) =3D=3D (unsigned long) -1) || (((=
__typeof (__n)) 0 < (__typeof (__n)) -1 || (__builtin_constant_p (__n) && (=
__n) > 0)) && __builtin_constant_p ((((unsigned long) (__n)) <=3D ((sz)) / =
((__size)))) && (((unsigned long) (__n)) <=3D ((sz)) / ((__size))))))
			return __fread_alias (__ptr, __size, __n, __stream);
		if ((((__typeof (__n)) 0 < (__typeof (__n)) -1 || (__builtin_constant_p (=
__n) && (__n) > 0)) && __builtin_constant_p ((((unsigned long) (__n)) <=3D =
(sz) / (__size))) && !(((unsigned long) (__n)) <=3D (sz) / (__size))))
			return __fread_chk_warn (__ptr, sz, __size, __n, __stream);
		return __fread_chk (__ptr, sz, __size, __n, __stream);
}
typedef void (*irq_offload_routine_t)(const void *parameter);
void irq_offload(irq_offload_routine_t routine, const void *parameter);
struct k_thread;
struct k_mem_domain;
typedef struct z_thread_stack_element k_thread_stack_t;
typedef void (*k_thread_entry_t)(void *p1, void *p2, void *p3);
static inline uint32_t arch_k_cycle_get_32(void);
static inline uint64_t arch_k_cycle_get_64(void);
void arch_cpu_idle(void);
void arch_cpu_atomic_idle(unsigned int key);
typedef __attribute__((__noreturn__)) void (*arch_cpustart_t)(void *data);
void arch_start_cpu(int cpu_num, k_thread_stack_t *stack, int sz,
			arch_cpustart_t fn, void *arg);
_Bool arch_cpu_active(int cpu_num);
static inline unsigned int arch_irq_lock(void);
static inline void arch_irq_unlock(unsigned int key);
static inline _Bool arch_irq_unlocked(unsigned int key);
void arch_irq_disable(unsigned int irq);
void arch_irq_enable(unsigned int irq);
int arch_irq_is_enabled(unsigned int irq);
int arch_irq_connect_dynamic(unsigned int irq, unsigned int priority,
			void (*routine)(const void *parameter),
			const void *parameter, uint32_t flags);
int arch_irq_disconnect_dynamic(unsigned int irq, unsigned int priority,
			void (*routine)(const void *parameter),
			const void *parameter, uint32_t flags);
unsigned int arch_irq_allocate(void);
void arch_irq_set_used(unsigned int irq);
_Bool arch_irq_is_used(unsigned int irq);
static inline unsigned int arch_num_cpus(void);
static inline _Bool arch_mem_coherent(void *ptr)
{
			(void)(ptr);
			return 1;
}
static inline void arch_cohere_stacks(struct k_thread *old_thread,
			void *old_switch_handle,
			struct k_thread *new_thread)
{
			(void)(old_thread);
			(void)(old_switch_handle);
			(void)(new_thread);
}
void arch_spin_relax(void);
static inline __attribute__((always_inline)) uint64_t read_ccsidr_el1(void)=
 { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "ccsidr_el1" : =
"=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((=
always_inline)) void write_ccsidr_el1(uint64_t val) { ({ __asm__ volatile (=
"msr " "ccsidr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __=
attribute__((always_inline)) void zero_ccsidr_el1(void) { ({ __asm__ volati=
le ("msr " "ccsidr_el1" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_clidr_el1(void) =
{ return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "clidr_el1" : "=
=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((a=
lways_inline)) void write_clidr_el1(uint64_t val) { ({ __asm__ volatile ("m=
sr " "clidr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __att=
ribute__((always_inline)) void zero_clidr_el1(void) { ({ __asm__ volatile (=
"msr " "clidr_el1" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_cntfrq_el0(void)=
 { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cntfrq_el0" : =
"=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((=
always_inline)) void write_cntfrq_el0(uint64_t val) { ({ __asm__ volatile (=
"msr " "cntfrq_el0" ", %0" :: "r" (val) : "memory"); }); } static inline __=
attribute__((always_inline)) void zero_cntfrq_el0(void) { ({ __asm__ volati=
le ("msr " "cntfrq_el0" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_cnthctl_el2(void=
) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cnthctl_el2" =
: "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__=
((always_inline)) void write_cnthctl_el2(uint64_t val) { ({ __asm__ volatil=
e ("msr " "cnthctl_el2" ", %0" :: "r" (val) : "memory"); }); } static inlin=
e __attribute__((always_inline)) void zero_cnthctl_el2(void) { ({ __asm__ v=
olatile ("msr " "cnthctl_el2" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_cnthp_ctl_el2(vo=
id) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cnthp_ctl_e=
l2" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribu=
te__((always_inline)) void write_cnthp_ctl_el2(uint64_t val) { ({ __asm__ v=
olatile ("msr " "cnthp_ctl_el2" ", %0" :: "r" (val) : "memory"); }); } stat=
ic inline __attribute__((always_inline)) void zero_cnthp_ctl_el2(void) { ({=
 __asm__ volatile ("msr " "cnthp_ctl_el2" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_cnthps_ctl_el2(v=
oid) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cnthps_ctl=
_el2" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attri=
bute__((always_inline)) void write_cnthps_ctl_el2(uint64_t val) { ({ __asm_=
_ volatile ("msr " "cnthps_ctl_el2" ", %0" :: "r" (val) : "memory"); }); } =
static inline __attribute__((always_inline)) void zero_cnthps_ctl_el2(void)=
 { ({ __asm__ volatile ("msr " "cnthps_ctl_el2" ", xzr" ::: "memory"); }); =
};
static inline __attribute__((always_inline)) uint64_t read_cntv_ctl_el0(voi=
d) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cntv_ctl_el0=
" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute=
__((always_inline)) void write_cntv_ctl_el0(uint64_t val) { ({ __asm__ vola=
tile ("msr " "cntv_ctl_el0" ", %0" :: "r" (val) : "memory"); }); } static i=
nline __attribute__((always_inline)) void zero_cntv_ctl_el0(void) { ({ __as=
m__ volatile ("msr " "cntv_ctl_el0" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_cntv_cval_el0(vo=
id) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cntv_cval_e=
l0" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribu=
te__((always_inline)) void write_cntv_cval_el0(uint64_t val) { ({ __asm__ v=
olatile ("msr " "cntv_cval_el0" ", %0" :: "r" (val) : "memory"); }); } stat=
ic inline __attribute__((always_inline)) void zero_cntv_cval_el0(void) { ({=
 __asm__ volatile ("msr " "cntv_cval_el0" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_cntvct_el0(void)=
 { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cntvct_el0" : =
"=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((=
always_inline)) void write_cntvct_el0(uint64_t val) { ({ __asm__ volatile (=
"msr " "cntvct_el0" ", %0" :: "r" (val) : "memory"); }); } static inline __=
attribute__((always_inline)) void zero_cntvct_el0(void) { ({ __asm__ volati=
le ("msr " "cntvct_el0" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_cntvoff_el2(void=
) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cntvoff_el2" =
: "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__=
((always_inline)) void write_cntvoff_el2(uint64_t val) { ({ __asm__ volatil=
e ("msr " "cntvoff_el2" ", %0" :: "r" (val) : "memory"); }); } static inlin=
e __attribute__((always_inline)) void zero_cntvoff_el2(void) { ({ __asm__ v=
olatile ("msr " "cntvoff_el2" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_currentel(void) =
{ return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "currentel" : "=
=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((a=
lways_inline)) void write_currentel(uint64_t val) { ({ __asm__ volatile ("m=
sr " "currentel" ", %0" :: "r" (val) : "memory"); }); } static inline __att=
ribute__((always_inline)) void zero_currentel(void) { ({ __asm__ volatile (=
"msr " "currentel" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_csselr_el1(void)=
 { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "csselr_el1" : =
"=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((=
always_inline)) void write_csselr_el1(uint64_t val) { ({ __asm__ volatile (=
"msr " "csselr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __=
attribute__((always_inline)) void zero_csselr_el1(void) { ({ __asm__ volati=
le ("msr " "csselr_el1" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_daif(void) { ret=
urn ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "daif" : "=3Dr" (reg_=
val) :: "memory"); reg_val; }); } static inline __attribute__((always_inlin=
e)) void write_daif(uint64_t val) { ({ __asm__ volatile ("msr " "daif" ", %=
0" :: "r" (val) : "memory"); }); } static inline __attribute__((always_inli=
ne)) void zero_daif(void) { ({ __asm__ volatile ("msr " "daif" ", xzr" ::: =
"memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_hcr_el2(void) { =
return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "hcr_el2" : "=3Dr"=
 (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always=
_inline)) void write_hcr_el2(uint64_t val) { ({ __asm__ volatile ("msr " "h=
cr_el2" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__(=
(always_inline)) void zero_hcr_el2(void) { ({ __asm__ volatile ("msr " "hcr=
_el2" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_id_aa64pfr0_el1(=
void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "id_aa64pf=
r0_el1" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __att=
ribute__((always_inline)) void write_id_aa64pfr0_el1(uint64_t val) { ({ __a=
sm__ volatile ("msr " "id_aa64pfr0_el1" ", %0" :: "r" (val) : "memory"); })=
; } static inline __attribute__((always_inline)) void zero_id_aa64pfr0_el1(=
void) { ({ __asm__ volatile ("msr " "id_aa64pfr0_el1" ", xzr" ::: "memory")=
; }); };
static inline __attribute__((always_inline)) uint64_t read_id_aa64mmfr0_el1=
(void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "id_aa64m=
mfr0_el1" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __a=
ttribute__((always_inline)) void write_id_aa64mmfr0_el1(uint64_t val) { ({ =
__asm__ volatile ("msr " "id_aa64mmfr0_el1" ", %0" :: "r" (val) : "memory")=
; }); } static inline __attribute__((always_inline)) void zero_id_aa64mmfr0=
_el1(void) { ({ __asm__ volatile ("msr " "id_aa64mmfr0_el1" ", xzr" ::: "me=
mory"); }); };
static inline __attribute__((always_inline)) uint64_t read_mpidr_el1(void) =
{ return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "mpidr_el1" : "=
=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((a=
lways_inline)) void write_mpidr_el1(uint64_t val) { ({ __asm__ volatile ("m=
sr " "mpidr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __att=
ribute__((always_inline)) void zero_mpidr_el1(void) { ({ __asm__ volatile (=
"msr " "mpidr_el1" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_par_el1(void) { =
return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "par_el1" : "=3Dr"=
 (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always=
_inline)) void write_par_el1(uint64_t val) { ({ __asm__ volatile ("msr " "p=
ar_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__(=
(always_inline)) void zero_par_el1(void) { ({ __asm__ volatile ("msr " "par=
_el1" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_scr_el3(void) { =
return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "scr_el3" : "=3Dr"=
 (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always=
_inline)) void write_scr_el3(uint64_t val) { ({ __asm__ volatile ("msr " "s=
cr_el3" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__(=
(always_inline)) void zero_scr_el3(void) { ({ __asm__ volatile ("msr " "scr=
_el3" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_tpidrro_el0(void=
) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "tpidrro_el0" =
: "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__=
((always_inline)) void write_tpidrro_el0(uint64_t val) { ({ __asm__ volatil=
e ("msr " "tpidrro_el0" ", %0" :: "r" (val) : "memory"); }); } static inlin=
e __attribute__((always_inline)) void zero_tpidrro_el0(void) { ({ __asm__ v=
olatile ("msr " "tpidrro_el0" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_vmpidr_el2(void)=
 { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "vmpidr_el2" : =
"=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((=
always_inline)) void write_vmpidr_el2(uint64_t val) { ({ __asm__ volatile (=
"msr " "vmpidr_el2" ", %0" :: "r" (val) : "memory"); }); } static inline __=
attribute__((always_inline)) void zero_vmpidr_el2(void) { ({ __asm__ volati=
le ("msr " "vmpidr_el2" ", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_sp_el0(void) { r=
eturn ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "sp_el0" : "=3Dr" (=
reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always_i=
nline)) void write_sp_el0(uint64_t val) { ({ __asm__ volatile ("msr " "sp_e=
l0" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__((alw=
ays_inline)) void zero_sp_el0(void) { ({ __asm__ volatile ("msr " "sp_el0" =
", xzr" ::: "memory"); }); };
static inline __attribute__((always_inline)) uint64_t read_actlr_el1(void) =
{ return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "actlr_el1" : "=
=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((a=
lways_inline)) void write_actlr_el1(uint64_t val) { ({ __asm__ volatile ("m=
sr " "actlr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __att=
ribute__((always_inline)) void zero_actlr_el1(void) { ({ __asm__ volatile (=
"msr " "actlr_el1" ", xzr" ::: "memory"); }); } static inline __attribute__=
((always_inline)) uint64_t read_actlr_el2(void) { return ({ uint64_t reg_va=
l; __asm__ volatile ("mrs %0, " "actlr_el2" : "=3Dr" (reg_val) :: "memory")=
; reg_val; }); } static inline __attribute__((always_inline)) void write_ac=
tlr_el2(uint64_t val) { ({ __asm__ volatile ("msr " "actlr_el2" ", %0" :: "=
r" (val) : "memory"); }); } static inline __attribute__((always_inline)) vo=
id zero_actlr_el2(void) { ({ __asm__ volatile ("msr " "actlr_el2" ", xzr" :=
:: "memory"); }); } static inline __attribute__((always_inline)) uint64_t r=
ead_actlr_el3(void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0=
, " "actlr_el3" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inli=
ne __attribute__((always_inline)) void write_actlr_el3(uint64_t val) { ({ _=
_asm__ volatile ("msr " "actlr_el3" ", %0" :: "r" (val) : "memory"); }); } =
static inline __attribute__((always_inline)) void zero_actlr_el3(void) { ({=
 __asm__ volatile ("msr " "actlr_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_cpacr_el1(void) =
{ return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cpacr_el1" : "=
=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((a=
lways_inline)) void write_cpacr_el1(uint64_t val) { ({ __asm__ volatile ("m=
sr " "cpacr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __att=
ribute__((always_inline)) void zero_cpacr_el1(void) { ({ __asm__ volatile (=
"msr " "cpacr_el1" ", xzr" ::: "memory"); }); } static inline __attribute__=
((always_inline)) uint64_t read_cpacr_el2(void) { return ({ uint64_t reg_va=
l; __asm__ volatile ("mrs %0, " "cpacr_el2" : "=3Dr" (reg_val) :: "memory")=
; reg_val; }); } static inline __attribute__((always_inline)) void write_cp=
acr_el2(uint64_t val) { ({ __asm__ volatile ("msr " "cpacr_el2" ", %0" :: "=
r" (val) : "memory"); }); } static inline __attribute__((always_inline)) vo=
id zero_cpacr_el2(void) { ({ __asm__ volatile ("msr " "cpacr_el2" ", xzr" :=
:: "memory"); }); } static inline __attribute__((always_inline)) uint64_t r=
ead_cpacr_el3(void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0=
, " "cpacr_el3" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inli=
ne __attribute__((always_inline)) void write_cpacr_el3(uint64_t val) { ({ _=
_asm__ volatile ("msr " "cpacr_el3" ", %0" :: "r" (val) : "memory"); }); } =
static inline __attribute__((always_inline)) void zero_cpacr_el3(void) { ({=
 __asm__ volatile ("msr " "cpacr_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_cptr_el1(void) {=
 return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cptr_el1" : "=3D=
r" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((alwa=
ys_inline)) void write_cptr_el1(uint64_t val) { ({ __asm__ volatile ("msr "=
 "cptr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribut=
e__((always_inline)) void zero_cptr_el1(void) { ({ __asm__ volatile ("msr "=
 "cptr_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((alway=
s_inline)) uint64_t read_cptr_el2(void) { return ({ uint64_t reg_val; __asm=
__ volatile ("mrs %0, " "cptr_el2" : "=3Dr" (reg_val) :: "memory"); reg_val=
; }); } static inline __attribute__((always_inline)) void write_cptr_el2(ui=
nt64_t val) { ({ __asm__ volatile ("msr " "cptr_el2" ", %0" :: "r" (val) : =
"memory"); }); } static inline __attribute__((always_inline)) void zero_cpt=
r_el2(void) { ({ __asm__ volatile ("msr " "cptr_el2" ", xzr" ::: "memory");=
 }); } static inline __attribute__((always_inline)) uint64_t read_cptr_el3(=
void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "cptr_el3"=
 : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute_=
_((always_inline)) void write_cptr_el3(uint64_t val) { ({ __asm__ volatile =
("msr " "cptr_el3" ", %0" :: "r" (val) : "memory"); }); } static inline __a=
ttribute__((always_inline)) void zero_cptr_el3(void) { ({ __asm__ volatile =
("msr " "cptr_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_elr_el1(void) { =
return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "elr_el1" : "=3Dr"=
 (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always=
_inline)) void write_elr_el1(uint64_t val) { ({ __asm__ volatile ("msr " "e=
lr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__(=
(always_inline)) void zero_elr_el1(void) { ({ __asm__ volatile ("msr " "elr=
_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((always_inli=
ne)) uint64_t read_elr_el2(void) { return ({ uint64_t reg_val; __asm__ vola=
tile ("mrs %0, " "elr_el2" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } =
static inline __attribute__((always_inline)) void write_elr_el2(uint64_t va=
l) { ({ __asm__ volatile ("msr " "elr_el2" ", %0" :: "r" (val) : "memory");=
 }); } static inline __attribute__((always_inline)) void zero_elr_el2(void)=
 { ({ __asm__ volatile ("msr " "elr_el2" ", xzr" ::: "memory"); }); } stati=
c inline __attribute__((always_inline)) uint64_t read_elr_el3(void) { retur=
n ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "elr_el3" : "=3Dr" (reg=
_val) :: "memory"); reg_val; }); } static inline __attribute__((always_inli=
ne)) void write_elr_el3(uint64_t val) { ({ __asm__ volatile ("msr " "elr_el=
3" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__((alwa=
ys_inline)) void zero_elr_el3(void) { ({ __asm__ volatile ("msr " "elr_el3"=
 ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_esr_el1(void) { =
return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "esr_el1" : "=3Dr"=
 (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always=
_inline)) void write_esr_el1(uint64_t val) { ({ __asm__ volatile ("msr " "e=
sr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__(=
(always_inline)) void zero_esr_el1(void) { ({ __asm__ volatile ("msr " "esr=
_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((always_inli=
ne)) uint64_t read_esr_el2(void) { return ({ uint64_t reg_val; __asm__ vola=
tile ("mrs %0, " "esr_el2" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } =
static inline __attribute__((always_inline)) void write_esr_el2(uint64_t va=
l) { ({ __asm__ volatile ("msr " "esr_el2" ", %0" :: "r" (val) : "memory");=
 }); } static inline __attribute__((always_inline)) void zero_esr_el2(void)=
 { ({ __asm__ volatile ("msr " "esr_el2" ", xzr" ::: "memory"); }); } stati=
c inline __attribute__((always_inline)) uint64_t read_esr_el3(void) { retur=
n ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "esr_el3" : "=3Dr" (reg=
_val) :: "memory"); reg_val; }); } static inline __attribute__((always_inli=
ne)) void write_esr_el3(uint64_t val) { ({ __asm__ volatile ("msr " "esr_el=
3" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__((alwa=
ys_inline)) void zero_esr_el3(void) { ({ __asm__ volatile ("msr " "esr_el3"=
 ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_far_el1(void) { =
return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "far_el1" : "=3Dr"=
 (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always=
_inline)) void write_far_el1(uint64_t val) { ({ __asm__ volatile ("msr " "f=
ar_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__(=
(always_inline)) void zero_far_el1(void) { ({ __asm__ volatile ("msr " "far=
_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((always_inli=
ne)) uint64_t read_far_el2(void) { return ({ uint64_t reg_val; __asm__ vola=
tile ("mrs %0, " "far_el2" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } =
static inline __attribute__((always_inline)) void write_far_el2(uint64_t va=
l) { ({ __asm__ volatile ("msr " "far_el2" ", %0" :: "r" (val) : "memory");=
 }); } static inline __attribute__((always_inline)) void zero_far_el2(void)=
 { ({ __asm__ volatile ("msr " "far_el2" ", xzr" ::: "memory"); }); } stati=
c inline __attribute__((always_inline)) uint64_t read_far_el3(void) { retur=
n ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "far_el3" : "=3Dr" (reg=
_val) :: "memory"); reg_val; }); } static inline __attribute__((always_inli=
ne)) void write_far_el3(uint64_t val) { ({ __asm__ volatile ("msr " "far_el=
3" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__((alwa=
ys_inline)) void zero_far_el3(void) { ({ __asm__ volatile ("msr " "far_el3"=
 ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_mair_el1(void) {=
 return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "mair_el1" : "=3D=
r" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((alwa=
ys_inline)) void write_mair_el1(uint64_t val) { ({ __asm__ volatile ("msr "=
 "mair_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribut=
e__((always_inline)) void zero_mair_el1(void) { ({ __asm__ volatile ("msr "=
 "mair_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((alway=
s_inline)) uint64_t read_mair_el2(void) { return ({ uint64_t reg_val; __asm=
__ volatile ("mrs %0, " "mair_el2" : "=3Dr" (reg_val) :: "memory"); reg_val=
; }); } static inline __attribute__((always_inline)) void write_mair_el2(ui=
nt64_t val) { ({ __asm__ volatile ("msr " "mair_el2" ", %0" :: "r" (val) : =
"memory"); }); } static inline __attribute__((always_inline)) void zero_mai=
r_el2(void) { ({ __asm__ volatile ("msr " "mair_el2" ", xzr" ::: "memory");=
 }); } static inline __attribute__((always_inline)) uint64_t read_mair_el3(=
void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "mair_el3"=
 : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute_=
_((always_inline)) void write_mair_el3(uint64_t val) { ({ __asm__ volatile =
("msr " "mair_el3" ", %0" :: "r" (val) : "memory"); }); } static inline __a=
ttribute__((always_inline)) void zero_mair_el3(void) { ({ __asm__ volatile =
("msr " "mair_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_sctlr_el1(void) =
{ return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "sctlr_el1" : "=
=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((a=
lways_inline)) void write_sctlr_el1(uint64_t val) { ({ __asm__ volatile ("m=
sr " "sctlr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __att=
ribute__((always_inline)) void zero_sctlr_el1(void) { ({ __asm__ volatile (=
"msr " "sctlr_el1" ", xzr" ::: "memory"); }); } static inline __attribute__=
((always_inline)) uint64_t read_sctlr_el2(void) { return ({ uint64_t reg_va=
l; __asm__ volatile ("mrs %0, " "sctlr_el2" : "=3Dr" (reg_val) :: "memory")=
; reg_val; }); } static inline __attribute__((always_inline)) void write_sc=
tlr_el2(uint64_t val) { ({ __asm__ volatile ("msr " "sctlr_el2" ", %0" :: "=
r" (val) : "memory"); }); } static inline __attribute__((always_inline)) vo=
id zero_sctlr_el2(void) { ({ __asm__ volatile ("msr " "sctlr_el2" ", xzr" :=
:: "memory"); }); } static inline __attribute__((always_inline)) uint64_t r=
ead_sctlr_el3(void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0=
, " "sctlr_el3" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inli=
ne __attribute__((always_inline)) void write_sctlr_el3(uint64_t val) { ({ _=
_asm__ volatile ("msr " "sctlr_el3" ", %0" :: "r" (val) : "memory"); }); } =
static inline __attribute__((always_inline)) void zero_sctlr_el3(void) { ({=
 __asm__ volatile ("msr " "sctlr_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_spsr_el1(void) {=
 return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "spsr_el1" : "=3D=
r" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((alwa=
ys_inline)) void write_spsr_el1(uint64_t val) { ({ __asm__ volatile ("msr "=
 "spsr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribut=
e__((always_inline)) void zero_spsr_el1(void) { ({ __asm__ volatile ("msr "=
 "spsr_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((alway=
s_inline)) uint64_t read_spsr_el2(void) { return ({ uint64_t reg_val; __asm=
__ volatile ("mrs %0, " "spsr_el2" : "=3Dr" (reg_val) :: "memory"); reg_val=
; }); } static inline __attribute__((always_inline)) void write_spsr_el2(ui=
nt64_t val) { ({ __asm__ volatile ("msr " "spsr_el2" ", %0" :: "r" (val) : =
"memory"); }); } static inline __attribute__((always_inline)) void zero_sps=
r_el2(void) { ({ __asm__ volatile ("msr " "spsr_el2" ", xzr" ::: "memory");=
 }); } static inline __attribute__((always_inline)) uint64_t read_spsr_el3(=
void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "spsr_el3"=
 : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute_=
_((always_inline)) void write_spsr_el3(uint64_t val) { ({ __asm__ volatile =
("msr " "spsr_el3" ", %0" :: "r" (val) : "memory"); }); } static inline __a=
ttribute__((always_inline)) void zero_spsr_el3(void) { ({ __asm__ volatile =
("msr " "spsr_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_tcr_el1(void) { =
return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "tcr_el1" : "=3Dr"=
 (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((always=
_inline)) void write_tcr_el1(uint64_t val) { ({ __asm__ volatile ("msr " "t=
cr_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__(=
(always_inline)) void zero_tcr_el1(void) { ({ __asm__ volatile ("msr " "tcr=
_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((always_inli=
ne)) uint64_t read_tcr_el2(void) { return ({ uint64_t reg_val; __asm__ vola=
tile ("mrs %0, " "tcr_el2" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } =
static inline __attribute__((always_inline)) void write_tcr_el2(uint64_t va=
l) { ({ __asm__ volatile ("msr " "tcr_el2" ", %0" :: "r" (val) : "memory");=
 }); } static inline __attribute__((always_inline)) void zero_tcr_el2(void)=
 { ({ __asm__ volatile ("msr " "tcr_el2" ", xzr" ::: "memory"); }); } stati=
c inline __attribute__((always_inline)) uint64_t read_tcr_el3(void) { retur=
n ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "tcr_el3" : "=3Dr" (reg=
_val) :: "memory"); reg_val; }); } static inline __attribute__((always_inli=
ne)) void write_tcr_el3(uint64_t val) { ({ __asm__ volatile ("msr " "tcr_el=
3" ", %0" :: "r" (val) : "memory"); }); } static inline __attribute__((alwa=
ys_inline)) void zero_tcr_el3(void) { ({ __asm__ volatile ("msr " "tcr_el3"=
 ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_ttbr0_el1(void) =
{ return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "ttbr0_el1" : "=
=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((a=
lways_inline)) void write_ttbr0_el1(uint64_t val) { ({ __asm__ volatile ("m=
sr " "ttbr0_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __att=
ribute__((always_inline)) void zero_ttbr0_el1(void) { ({ __asm__ volatile (=
"msr " "ttbr0_el1" ", xzr" ::: "memory"); }); } static inline __attribute__=
((always_inline)) uint64_t read_ttbr0_el2(void) { return ({ uint64_t reg_va=
l; __asm__ volatile ("mrs %0, " "ttbr0_el2" : "=3Dr" (reg_val) :: "memory")=
; reg_val; }); } static inline __attribute__((always_inline)) void write_tt=
br0_el2(uint64_t val) { ({ __asm__ volatile ("msr " "ttbr0_el2" ", %0" :: "=
r" (val) : "memory"); }); } static inline __attribute__((always_inline)) vo=
id zero_ttbr0_el2(void) { ({ __asm__ volatile ("msr " "ttbr0_el2" ", xzr" :=
:: "memory"); }); } static inline __attribute__((always_inline)) uint64_t r=
ead_ttbr0_el3(void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0=
, " "ttbr0_el3" : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inli=
ne __attribute__((always_inline)) void write_ttbr0_el3(uint64_t val) { ({ _=
_asm__ volatile ("msr " "ttbr0_el3" ", %0" :: "r" (val) : "memory"); }); } =
static inline __attribute__((always_inline)) void zero_ttbr0_el3(void) { ({=
 __asm__ volatile ("msr " "ttbr0_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) uint64_t read_vbar_el1(void) {=
 return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "vbar_el1" : "=3D=
r" (reg_val) :: "memory"); reg_val; }); } static inline __attribute__((alwa=
ys_inline)) void write_vbar_el1(uint64_t val) { ({ __asm__ volatile ("msr "=
 "vbar_el1" ", %0" :: "r" (val) : "memory"); }); } static inline __attribut=
e__((always_inline)) void zero_vbar_el1(void) { ({ __asm__ volatile ("msr "=
 "vbar_el1" ", xzr" ::: "memory"); }); } static inline __attribute__((alway=
s_inline)) uint64_t read_vbar_el2(void) { return ({ uint64_t reg_val; __asm=
__ volatile ("mrs %0, " "vbar_el2" : "=3Dr" (reg_val) :: "memory"); reg_val=
; }); } static inline __attribute__((always_inline)) void write_vbar_el2(ui=
nt64_t val) { ({ __asm__ volatile ("msr " "vbar_el2" ", %0" :: "r" (val) : =
"memory"); }); } static inline __attribute__((always_inline)) void zero_vba=
r_el2(void) { ({ __asm__ volatile ("msr " "vbar_el2" ", xzr" ::: "memory");=
 }); } static inline __attribute__((always_inline)) uint64_t read_vbar_el3(=
void) { return ({ uint64_t reg_val; __asm__ volatile ("mrs %0, " "vbar_el3"=
 : "=3Dr" (reg_val) :: "memory"); reg_val; }); } static inline __attribute_=
_((always_inline)) void write_vbar_el3(uint64_t val) { ({ __asm__ volatile =
("msr " "vbar_el3" ", %0" :: "r" (val) : "memory"); }); } static inline __a=
ttribute__((always_inline)) void zero_vbar_el3(void) { ({ __asm__ volatile =
("msr " "vbar_el3" ", xzr" ::: "memory"); }); }
static inline __attribute__((always_inline)) void enable_debug_exceptions(v=
oid)
{
			__asm__ volatile ("msr DAIFClr, %0"
			:: "i" ((1UL << (3))) : "memory");
}
static inline __attribute__((always_inline)) void disable_debug_exceptions(=
void)
{
			__asm__ volatile ("msr DAIFSet, %0"
			:: "i" ((1UL << (3))) : "memory");
}
static inline __attribute__((always_inline)) void enable_serror_exceptions(=
void)
{
			__asm__ volatile ("msr DAIFClr, %0"
			:: "i" ((1UL << (2))) : "memory");
}
static inline __attribute__((always_inline)) void disable_serror_exceptions=
(void)
{
			__asm__ volatile ("msr DAIFSet, %0"
			:: "i" ((1UL << (2))) : "memory");
}
static inline __attribute__((always_inline)) void enable_irq(void)
{
			__asm__ volatile ("msr DAIFClr, %0"
			:: "i" ((1UL << (1))) : "memory");
}
static inline __attribute__((always_inline)) void disable_irq(void)
{
			__asm__ volatile ("msr DAIFSet, %0"
			:: "i" ((1UL << (1))) : "memory");
}
static inline __attribute__((always_inline)) void enable_fiq(void)
{
			__asm__ volatile ("msr DAIFClr, %0"
			:: "i" ((1UL << (0))) : "memory");
}
static inline __attribute__((always_inline)) void disable_fiq(void)
{
			__asm__ volatile ("msr DAIFSet, %0"
			:: "i" ((1UL << (0))) : "memory");
}
static inline _Bool is_el_implemented(unsigned int el)
{
			unsigned int shift;
			if (el > 3) {
			return 0;
			}
			shift =3D (4) * el;
			return (((read_id_aa64pfr0_el1() >> shift) & (0xf)) !=3D 0U);
}
static inline _Bool is_el_highest_implemented(void)
{
			uint32_t el_highest;
			uint32_t curr_el;
			el_highest =3D read_id_aa64pfr0_el1() & 0xFFFF;
			el_highest =3D (31U - __builtin_clz(el_highest)) / 4;
			curr_el =3D (((read_currentel()) >> (0x2)) & (0x3));
			if (curr_el < el_highest)
			return 0;
			return 1;
}
static inline _Bool is_el2_sec_supported(void)
{
			return (((read_id_aa64pfr0_el1() >> (36)) &
			(0xf)) !=3D 0U);
}
static inline _Bool is_in_secure_state(void)
{
			return !0;
}
static inline __attribute__((always_inline)) _cpu_t *arch_curr_cpu(void)
{
			return (_cpu_t *)(read_tpidrro_el0() & 0x0000fffffffffff8);
}
static inline __attribute__((always_inline)) int arch_exception_depth(void)
{
			return (read_tpidrro_el0() & 0xff00000000000000) / 0x0100000000000000;
}
static inline __attribute__((always_inline)) uint32_t arch_proc_id(void)
{
			uint64_t cpu_mpid =3D read_mpidr_el1();
			{ };
			return (uint32_t)cpu_mpid;
}
static inline __attribute__((always_inline)) unsigned int arch_num_cpus(voi=
d)
{
			return 1;
}
typedef struct
		{
			int quot;
			int rem;
		} div_t;
typedef struct
		{
			long int quot;
			long int rem;
		} ldiv_t; typedef struct
		{
			long long int quot;
			long long int rem;
		} lldiv_t;
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__ , _=
_leaf__)) __attribute__ ((__warn_unused_result__));
extern double atof (const char *__nptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1))) __attribute__ ((__warn_unused_result__));
extern int atoi (const char *__nptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1))) __attribute__ ((__warn_unused_result__));
extern long int atol (const char *__nptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1))) __attribute__ ((__warn_unused_result__)); ext=
ern long long int atoll (const char *__nptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1))) __attribute__ ((__warn_unused_result__));
extern double strtod (const char *__restrict __nptr,
			char **__restrict __endptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)=
));
extern float strtof (const char *__restrict __nptr,
			char **__restrict __endptr) __attribute__ ((__nothrow__ , __leaf__)) __a=
ttribute__ ((__nonnull__ (1)));
extern long double strtold (const char *__restrict __nptr,
			char **__restrict __endptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)=
));
extern long int strtol (const char *__restrict __nptr,
			char **__restrict __endptr, int __base)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)=
));
extern unsigned long int strtoul (const char *__restrict __nptr,
			char **__restrict __endptr, int __base)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)=
));
extern long long int strtoll (const char *__restrict __nptr,
			char **__restrict __endptr, int __base)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)=
));
extern unsigned long long int strtoull (const char *__restrict __nptr,
			char **__restrict __endptr, int __base)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)=
));
extern int rand (void) __attribute__ ((__nothrow__ , __leaf__));
extern void srand (unsigned int __seed) __attribute__ ((__nothrow__ , __lea=
f__));
extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__ , __le=
af__));
extern void *malloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)=
) __attribute__ ((__malloc__))
			__attribute__ ((__alloc_size__ (1))) __attribute__ ((__warn_unused_resul=
t__));
extern void *calloc (size_t __nmemb, size_t __size)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __=
attribute__ ((__alloc_size__ (1, 2))) __attribute__ ((__warn_unused_result_=
_));
extern void *realloc (void *__ptr, size_t __size)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_r=
esult__)) __attribute__ ((__alloc_size__ (2)));
extern void free (void *__ptr) __attribute__ ((__nothrow__ , __leaf__));
extern int posix_memalign (void **__memptr, size_t __alignment, size_t __si=
ze)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)=
)) __attribute__ ((__warn_unused_result__));
extern void abort (void) __attribute__ ((__nothrow__ , __leaf__)) __attribu=
te__ ((__noreturn__));
extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__ , __l=
eaf__)) __attribute__ ((__nonnull__ (1)));
extern void exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __=
attribute__ ((__noreturn__));
extern void _Exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) _=
_attribute__ ((__noreturn__));
extern char *getenv (const char *__name) __attribute__ ((__nothrow__ , __le=
af__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__warn_unused_resu=
lt__));
extern int setenv (const char *__name, const char *__value, int __replace)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)=
));
extern int unsetenv (const char *__name) __attribute__ ((__nothrow__ , __le=
af__)) __attribute__ ((__nonnull__ (1)));
extern int mkstemp (char *__template) __attribute__ ((__nonnull__ (1))) __a=
ttribute__ ((__warn_unused_result__));
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__ , __lea=
f__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__warn_unused_resul=
t__));
extern int system (const char *__command) __attribute__ ((__warn_unused_res=
ult__));
typedef int (*__compar_fn_t) (const void *, const void *);
extern void *bsearch (const void *__key, const void *__base,
			size_t __nmemb, size_t __size, __compar_fn_t __compar)
			__attribute__ ((__nonnull__ (1, 2, 5))) __attribute__ ((__warn_unused_re=
sult__));
extern void qsort (void *__base, size_t __nmemb, size_t __size,
			__compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));
extern int abs (int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribu=
te__ ((__const__)) __attribute__ ((__warn_unused_result__));
extern long int labs (long int __x) __attribute__ ((__nothrow__ , __leaf__)=
) __attribute__ ((__const__)) __attribute__ ((__warn_unused_result__)); ext=
ern long long int llabs (long long int __x)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) __a=
ttribute__ ((__warn_unused_result__));
extern div_t div (int __numer, int __denom)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) __a=
ttribute__ ((__warn_unused_result__));
extern ldiv_t ldiv (long int __numer, long int __denom)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) __a=
ttribute__ ((__warn_unused_result__)); extern lldiv_t lldiv (long long int =
__numer,
			long long int __denom)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) __a=
ttribute__ ((__warn_unused_result__));
extern int mblen (const char *__s, size_t __n) __attribute__ ((__nothrow__ =
, __leaf__));
extern int mbtowc (wchar_t *__restrict __pwc,
			const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __=
leaf__));
extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__ =
, __leaf__));
extern size_t mbstowcs (wchar_t *__restrict __pwcs,
			const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __=
leaf__))
			__attribute__ ((__access__ (__read_only__, 2)));
extern size_t wcstombs (char *__restrict __s,
			const wchar_t *__restrict __pwcs, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__))
		__attribute__ ((__access__ (__write_only__, 1, 3)))
		__attribute__ ((__access__ (__read_only__, 2)));
extern int getsubopt (char **__restrict __optionp,
			char *const *__restrict __tokens,
			char **__restrict __valuep)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2, 3))) __attribute__ ((__warn_unused_result__));
extern char *__realpath_chk (const char *__restrict __name,
			char *__restrict __resolved,
			size_t __resolvedlen) __attribute__ ((__nothrow__ , __leaf__)) __attribu=
te__ ((__warn_unused_result__));
extern char *__realpath_alias (const char *__restrict __name, char *__restr=
ict __resolved) __asm__ ("__USER_LABEL_PREFIX__" "realpath") __attribute__ =
((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__));
extern char *__realpath_chk_warn (const char *__restrict __name, char *__re=
strict __resolved, size_t __resolvedlen) __asm__ ("__USER_LABEL_PREFIX__" "=
__realpath_chk") __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((_=
_warn_unused_result__))
			__attribute__((__warning__ ("second argument of realpath must be either =
NULL or at " "least PATH_MAX bytes long buffer")));
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) __attribute__ ((__warn_unused_result__)) char *
__attribute__ ((__nothrow__ , __leaf__)) realpath (const char *__restrict _=
_name, char *__restrict __resolved)
{
		size_t sz =3D __builtin_object_size (__resolved, 1 > 1);
		if (sz =3D=3D (size_t) -1)
			return __realpath_alias (__name, __resolved);
		if ((((__typeof (4096)) 0 < (__typeof (4096)) -1 || (__builtin_constant_p=
 (4096) && (4096) > 0)) && __builtin_constant_p ((((unsigned long) (4096)) =
<=3D (sz) / (sizeof (char)))) && !(((unsigned long) (4096)) <=3D (sz) / (si=
zeof (char)))))
			return __realpath_chk_warn (__name, __resolved, sz);
		return __realpath_chk (__name, __resolved, sz);
}
extern int __ptsname_r_chk (int __fd, char *__buf, size_t __buflen,
			size_t __nreal) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ (=
(__nonnull__ (2)))
			__attribute__ ((__access__ (__write_only__, 2, 3)));
extern int __ptsname_r_alias (int __fd, char *__buf, size_t __buflen) __asm=
__ ("__USER_LABEL_PREFIX__" "ptsname_r") __attribute__ ((__nothrow__ , __le=
af__))
			__attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_on=
ly__, 2, 3)));
extern int __ptsname_r_chk_warn (int __fd, char *__buf, size_t __buflen, si=
ze_t __nreal) __asm__ ("__USER_LABEL_PREFIX__" "__ptsname_r_chk") __attribu=
te__ ((__nothrow__ , __leaf__))
			__attribute__ ((__nonnull__ (2))) __attribute__((__warning__ ("ptsname_r=
 called with buflen bigger than " "size of buf")));
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) int
__attribute__ ((__nothrow__ , __leaf__)) ptsname_r (int __fd, char *__buf, =
size_t __buflen)
{
		return (((__builtin_constant_p (__builtin_object_size (__buf, 1 > 1)) && =
(__builtin_object_size (__buf, 1 > 1)) =3D=3D (unsigned long) -1) || (((__t=
ypeof (__buflen)) 0 < (__typeof (__buflen)) -1 || (__builtin_constant_p (__=
buflen) && (__buflen) > 0)) && __builtin_constant_p ((((unsigned long) (__b=
uflen)) <=3D ((__builtin_object_size (__buf, 1 > 1))) / ((sizeof (char)))))=
 && (((unsigned long) (__buflen)) <=3D ((__builtin_object_size (__buf, 1 > =
1))) / ((sizeof (char)))))) ? __ptsname_r_alias (__fd, __buf, __buflen) : (=
(((__typeof (__buflen)) 0 < (__typeof (__buflen)) -1 || (__builtin_constant=
_p (__buflen) && (__buflen) > 0)) && __builtin_constant_p ((((unsigned long=
) (__buflen)) <=3D (__builtin_object_size (__buf, 1 > 1)) / (sizeof (char))=
)) && !(((unsigned long) (__buflen)) <=3D (__builtin_object_size (__buf, 1 =
> 1)) / (sizeof (char)))) ? __ptsname_r_chk_warn (__fd, __buf, __buflen, __=
builtin_object_size (__buf, 1 > 1)) : __ptsname_r_chk (__fd, __buf, __bufle=
n, __builtin_object_size (__buf, 1 > 1))));
}
extern int __wctomb_chk (char *__s, wchar_t __wchar, size_t __buflen)
		__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_re=
sult__));
extern int __wctomb_alias (char *__s, wchar_t __wchar) __asm__ ("__USER_LAB=
EL_PREFIX__" "wctomb") __attribute__ ((__nothrow__ , __leaf__)) __attribute=
__ ((__warn_unused_result__));
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) __attribute__ ((__warn_unused_result__)) int
__attribute__ ((__nothrow__ , __leaf__)) wctomb (char *__s, wchar_t __wchar=
)
{
		if (__builtin_object_size (__s, 1 > 1) !=3D (size_t) -1
			&& 16 > __builtin_object_size (__s, 1 > 1))
			return __wctomb_chk (__s, __wchar, __builtin_object_size (__s, 1 > 1));
		return __wctomb_alias (__s, __wchar);
}
extern size_t __mbstowcs_chk (wchar_t *__restrict __dst,
			const char *__restrict __src,
			size_t __len, size_t __dstlen) __attribute__ ((__nothrow__ , __leaf__))
			__attribute__ ((__access__ (__write_only__, 1, 3))) __attribute__ ((__ac=
cess__ (__read_only__, 2)));
extern size_t __mbstowcs_nulldst (wchar_t *__restrict __dst, const char *__=
restrict __src, size_t __len) __asm__ ("__USER_LABEL_PREFIX__" "mbstowcs") =
__attribute__ ((__nothrow__ , __leaf__))
			__attribute__ ((__access__ (__read_only__, 2)));
extern size_t __mbstowcs_alias (wchar_t *__restrict __dst, const char *__re=
strict __src, size_t __len) __asm__ ("__USER_LABEL_PREFIX__" "mbstowcs") __=
attribute__ ((__nothrow__ , __leaf__))
			__attribute__ ((__access__ (__write_only__, 1, 3))) __attribute__ ((__ac=
cess__ (__read_only__, 2)));
extern size_t __mbstowcs_chk_warn (wchar_t *__restrict __dst, const char *_=
_restrict __src, size_t __len, size_t __dstlen) __asm__ ("__USER_LABEL_PREF=
IX__" "__mbstowcs_chk") __attribute__ ((__nothrow__ , __leaf__))
			__attribute__((__warning__ ("mbstowcs called with dst buffer smaller tha=
n len " "* sizeof (wchar_t)")));
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) size_t
__attribute__ ((__nothrow__ , __leaf__)) mbstowcs (wchar_t *__restrict __ds=
t, const char *__restrict __src, size_t __len)
{
		if (__builtin_constant_p (__dst =3D=3D ((void *)0)) && __dst =3D=3D ((voi=
d *)0))
			return __mbstowcs_nulldst (__dst, __src, __len);
		else
			return (((__builtin_constant_p (__builtin_object_size (__dst, 1 > 1)) &&=
 (__builtin_object_size (__dst, 1 > 1)) =3D=3D (unsigned long) -1) || (((__=
typeof (__len)) 0 < (__typeof (__len)) -1 || (__builtin_constant_p (__len) =
&& (__len) > 0)) && __builtin_constant_p ((((unsigned long) (__len)) <=3D (=
(__builtin_object_size (__dst, 1 > 1))) / ((sizeof (wchar_t))))) && (((unsi=
gned long) (__len)) <=3D ((__builtin_object_size (__dst, 1 > 1))) / ((sizeo=
f (wchar_t)))))) ? __mbstowcs_alias (__dst, __src, __len) : ((((__typeof (_=
_len)) 0 < (__typeof (__len)) -1 || (__builtin_constant_p (__len) && (__len=
) > 0)) && __builtin_constant_p ((((unsigned long) (__len)) <=3D (__builtin=
_object_size (__dst, 1 > 1)) / (sizeof (wchar_t)))) && !(((unsigned long) (=
__len)) <=3D (__builtin_object_size (__dst, 1 > 1)) / (sizeof (wchar_t)))) =
? __mbstowcs_chk_warn (__dst, __src, __len, (__builtin_object_size (__dst, =
1 > 1)) / (sizeof (wchar_t))) : __mbstowcs_chk (__dst, __src, __len, (__bui=
ltin_object_size (__dst, 1 > 1)) / (sizeof (wchar_t)))));
}
extern size_t __wcstombs_chk (char *__restrict __dst,
			const wchar_t *__restrict __src,
			size_t __len, size_t __dstlen) __attribute__ ((__nothrow__ , __leaf__))
		__attribute__ ((__access__ (__write_only__, 1, 3))) __attribute__ ((__acc=
ess__ (__read_only__, 2)));
extern size_t __wcstombs_alias (char *__restrict __dst, const wchar_t *__re=
strict __src, size_t __len) __asm__ ("__USER_LABEL_PREFIX__" "wcstombs") __=
attribute__ ((__nothrow__ , __leaf__))
		__attribute__ ((__access__ (__write_only__, 1, 3))) __attribute__ ((__acc=
ess__ (__read_only__, 2)));
extern size_t __wcstombs_chk_warn (char *__restrict __dst, const wchar_t *_=
_restrict __src, size_t __len, size_t __dstlen) __asm__ ("__USER_LABEL_PREF=
IX__" "__wcstombs_chk") __attribute__ ((__nothrow__ , __leaf__))
			__attribute__((__warning__ ("wcstombs called with dst buffer smaller tha=
n len")));
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) size_t
__attribute__ ((__nothrow__ , __leaf__)) wcstombs (char *__restrict __dst, =
const wchar_t *__restrict __src, size_t __len)
{
		return (((__builtin_constant_p (__builtin_object_size (__dst, 1 > 1)) && =
(__builtin_object_size (__dst, 1 > 1)) =3D=3D (unsigned long) -1) || (((__t=
ypeof (__len)) 0 < (__typeof (__len)) -1 || (__builtin_constant_p (__len) &=
& (__len) > 0)) && __builtin_constant_p ((((unsigned long) (__len)) <=3D ((=
__builtin_object_size (__dst, 1 > 1))) / ((sizeof (char))))) && (((unsigned=
 long) (__len)) <=3D ((__builtin_object_size (__dst, 1 > 1))) / ((sizeof (c=
har)))))) ? __wcstombs_alias (__dst, __src, __len) : ((((__typeof (__len)) =
0 < (__typeof (__len)) -1 || (__builtin_constant_p (__len) && (__len) > 0))=
 && __builtin_constant_p ((((unsigned long) (__len)) <=3D (__builtin_object=
_size (__dst, 1 > 1)) / (sizeof (char)))) && !(((unsigned long) (__len)) <=
=3D (__builtin_object_size (__dst, 1 > 1)) / (sizeof (char)))) ? __wcstombs=
_chk_warn (__dst, __src, __len, __builtin_object_size (__dst, 1 > 1)) : __w=
cstombs_chk (__dst, __src, __len, __builtin_object_size (__dst, 1 > 1))));
}
struct arm_mmu_region {
			uintptr_t base_pa;
			uintptr_t base_va;
			size_t size;
			const char *name;
			uint32_t attrs;
};
struct arm_mmu_config {
			unsigned int num_regions;
			const struct arm_mmu_region *mmu_regions;
};
struct arm_mmu_ptables {
			uint64_t *base_xlat_table;
			uint64_t ttbr0;
};
typedef struct { uint32_t attrs; } k_mem_partition_attr_t;
extern const struct arm_mmu_config mmu_config;
struct k_thread;
void z_arm64_thread_mem_domains_init(struct k_thread *thread);
void z_arm64_swap_mem_domains(struct k_thread *thread);
struct _callee_saved {
			uint64_t x19;
			uint64_t x20;
			uint64_t x21;
			uint64_t x22;
			uint64_t x23;
			uint64_t x24;
			uint64_t x25;
			uint64_t x26;
			uint64_t x27;
			uint64_t x28;
			uint64_t x29;
			uint64_t sp_el0;
			uint64_t sp_elx;
			uint64_t lr;
};
typedef struct _callee_saved _callee_saved_t;
struct z_arm64_fp_context {
			__int128 q0, q1, q2, q3, q4, q5, q6, q7;
			__int128 q8, q9, q10, q11, q12, q13, q14, q15;
			__int128 q16, q17, q18, q19, q20, q21, q22, q23;
			__int128 q24, q25, q26, q27, q28, q29, q30, q31;
			uint32_t fpsr, fpcr;
};
struct _thread_arch {
			struct z_arm64_fp_context saved_fp_context;
			uint8_t exception_depth;
};
typedef struct _thread_arch _thread_arch_t;
struct __esf {
			uint64_t x0;
			uint64_t x1;
			uint64_t x2;
			uint64_t x3;
			uint64_t x4;
			uint64_t x5;
			uint64_t x6;
			uint64_t x7;
			uint64_t x8;
			uint64_t x9;
			uint64_t x10;
			uint64_t x11;
			uint64_t x12;
			uint64_t x13;
			uint64_t x14;
			uint64_t x15;
			uint64_t x16;
			uint64_t x17;
			uint64_t x18;
			uint64_t lr;
			uint64_t spsr;
			uint64_t elr;
} __attribute__((__aligned__(16)));
typedef struct __esf z_arch_esf_t;
static inline int
irq_connect_dynamic(unsigned int irq, unsigned int priority,
			void (*routine)(const void *parameter),
			const void *parameter, uint32_t flags)
{
			return arch_irq_connect_dynamic(irq, priority, routine, parameter,
			flags);
}
static inline int
irq_disconnect_dynamic(unsigned int irq, unsigned int priority,
			void (*routine)(const void *parameter),
			const void *parameter, uint32_t flags)
{
			return arch_irq_disconnect_dynamic(irq, priority, routine,
			parameter, flags);
}
struct device;
union init_function {
			int (*sys)(void);
			int (*dev)(const struct device *dev);
};
struct init_entry {
			union init_function init_fn;
			union {
			const struct device *dev;
			};
};
_Bool sys_mm_is_phys_addr_in_range(uintptr_t phys);
_Bool sys_mm_is_virt_addr_in_range(void *virt);
static inline uintptr_t z_mem_phys_addr(void *virt)
{
			uintptr_t addr =3D (uintptr_t)virt;
			{ };
			return ((addr) - ((0x200000 + 0x0) - (0x200000 + 0x0)));
}
static inline void *z_mem_virt_addr(uintptr_t phys)
{
			{ };
			return (void *)((phys) + ((0x200000 + 0x0) - (0x200000 + 0x0)));
}
void z_phys_map(uint8_t **virt_ptr, uintptr_t phys, size_t size,
			uint32_t flags);
void z_phys_unmap(uint8_t *virt, size_t size);
size_t k_mem_free_get(void);
void *k_mem_map(size_t size, uint32_t flags);
void k_mem_unmap(void *addr, size_t size);
size_t k_mem_region_align(uintptr_t *aligned_addr, size_t *aligned_size,
			uintptr_t addr, size_t size, size_t align);
typedef uint32_t io_port_t;
typedef uintptr_t mm_reg_t;
typedef uintptr_t mem_addr_t;
struct z_device_mmio_rom {
			uintptr_t phys_addr;
			size_t size;
};
static inline void device_map(mm_reg_t *virt_addr, uintptr_t phys_addr,
			size_t size, uint32_t flags)
{
			z_phys_map((uint8_t **)virt_addr, phys_addr, size,
			flags | (1UL << (3)));
}
typedef int16_t device_handle_t;
struct device_state {
			uint8_t init_res;
			_Bool initialized : 1;
};
struct pm_device;
struct device {
			const char *name;
			const void *config;
			const void *api;
			struct device_state *state;
			void *data;
};
static inline device_handle_t device_handle_get(const struct device *dev)
{
			device_handle_t ret =3D 0;
			extern struct device _device_list_start[];
			if (dev !=3D ((void *)0)) {
			ret =3D 1 + (device_handle_t)(dev - _device_list_start);
			}
			return ret;
}
static inline const struct device *
device_from_handle(device_handle_t dev_handle)
{
			extern struct device _device_list_start[];
			const struct device *dev =3D ((void *)0);
			size_t numdev;
			do { extern struct device _device_list_start[]; extern struct device _de=
vice_list_end[]; *(&numdev) =3D ((uintptr_t)_device_list_end - (uintptr_t)_=
device_list_start) / sizeof(struct device); } while (0);;
			if ((dev_handle > 0) && ((size_t)dev_handle <=3D numdev)) {
			dev =3D &_device_list_start[dev_handle - 1];
			}
			return dev;
}
static inline const struct device *device_get_binding(const char *name);
size_t z_device_get_all_static(const struct device **devices);
_Bool z_device_is_ready(const struct device *dev);
static inline _Bool device_is_ready(const struct device *dev);
static inline _Bool z_impl_device_is_ready(const struct device *dev)
{
			return z_device_is_ready(dev);
}
extern const struct device __device_dts_ord_0; extern const struct device _=
_device_dts_ord_2; extern const struct device __device_dts_ord_1; extern co=
nst struct device __device_dts_ord_3; extern const struct device __device_d=
ts_ord_12; extern const struct device __device_dts_ord_4; extern const stru=
ct device __device_dts_ord_8; extern const struct device __device_dts_ord_9=
; extern const struct device __device_dts_ord_13; extern const struct devic=
e __device_dts_ord_6; extern const struct device __device_dts_ord_7; extern=
 const struct device __device_dts_ord_5; extern const struct device __devic=
e_dts_ord_10; extern const struct device __device_dts_ord_11;
extern const struct device * z_impl_device_get_binding(const char * name);
static inline const struct device * device_get_binding(const char * name)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_device_get_binding(name);
}
extern _Bool z_impl_device_is_ready(const struct device * dev);
static inline _Bool device_is_ready(const struct device * dev)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_device_is_ready(dev);
}
void _isr_wrapper(void);
void z_irq_spurious(const void *unused);
struct _isr_table_entry {
			const void *arg;
			void (*isr)(const void *);
};
extern struct _isr_table_entry _sw_isr_table[];
struct _irq_parent_entry {
			const struct device *dev;
			unsigned int irq;
			unsigned int offset;
};
struct _isr_list {
			int32_t irq;
			int32_t flags;
			void *func;
			const void *param;
};
extern void arch_irq_enable(unsigned int irq);
extern void arch_irq_disable(unsigned int irq);
extern int arch_irq_is_enabled(unsigned int irq);
extern void z_arm64_irq_priority_set(unsigned int irq, unsigned int prio,
			uint32_t flags);
extern void z_arm64_interrupt_init(void);
extern uint32_t sys_clock_cycle_get_32(void);
static inline uint32_t arch_k_cycle_get_32(void)
{
			return sys_clock_cycle_get_32();
}
extern uint64_t sys_clock_cycle_get_64(void);
static inline uint64_t arch_k_cycle_get_64(void)
{
			return sys_clock_cycle_get_64();
}
static inline __attribute__((always_inline)) void arch_nop(void)
{
			__asm__ volatile("nop");
}
static inline __attribute__((always_inline)) unsigned int arch_irq_lock(voi=
d)
{
			unsigned int key;
			key =3D read_daif();
			disable_irq();
			return key;
}
static inline __attribute__((always_inline)) void arch_irq_unlock(unsigned =
int key)
{
			write_daif(key);
}
static inline __attribute__((always_inline)) _Bool arch_irq_unlocked(unsign=
ed int key)
{
			return (key & (1UL << (7))) =3D=3D 0;
}
static inline __attribute__((always_inline)) void z_barrier_dmem_fence_full=
(void)
{
			__asm__ volatile ("dmb sy" ::: "memory");
}
static inline __attribute__((always_inline)) void z_barrier_dsync_fence_ful=
l(void)
{
			__asm__ volatile ("dsb sy" ::: "memory");
}
static inline __attribute__((always_inline)) void z_barrier_isync_fence_ful=
l(void)
{
			__asm__ volatile ("isb" ::: "memory");
}
static inline __attribute__((always_inline)) void barrier_dmem_fence_full(v=
oid)
{
			z_barrier_dmem_fence_full();
}
static inline __attribute__((always_inline)) void barrier_dsync_fence_full(=
void)
{
			z_barrier_dsync_fence_full();
}
static inline __attribute__((always_inline)) void barrier_isync_fence_full(=
void)
{
			z_barrier_isync_fence_full();
}
static inline __attribute__((always_inline)) uint8_t sys_read8(mem_addr_t a=
ddr)
{
			uint8_t val;
			__asm__ volatile("ldrb %w0, [%1]" : "=3Dr" (val) : "r" (addr));
			barrier_dmem_fence_full();
			return val;
}
static inline __attribute__((always_inline)) void sys_write8(uint8_t data, =
mem_addr_t addr)
{
			barrier_dmem_fence_full();
			__asm__ volatile("strb %w0, [%1]" : : "r" (data), "r" (addr));
}
static inline __attribute__((always_inline)) uint16_t sys_read16(mem_addr_t=
 addr)
{
			uint16_t val;
			__asm__ volatile("ldrh %w0, [%1]" : "=3Dr" (val) : "r" (addr));
			barrier_dmem_fence_full();
			return val;
}
static inline __attribute__((always_inline)) void sys_write16(uint16_t data=
, mem_addr_t addr)
{
			barrier_dmem_fence_full();
			__asm__ volatile("strh %w0, [%1]" : : "r" (data), "r" (addr));
}
static inline __attribute__((always_inline)) uint32_t sys_read32(mem_addr_t=
 addr)
{
			uint32_t val;
			__asm__ volatile("ldr %w0, [%1]" : "=3Dr" (val) : "r" (addr));
			barrier_dmem_fence_full();
			return val;
}
static inline __attribute__((always_inline)) void sys_write32(uint32_t data=
, mem_addr_t addr)
{
			barrier_dmem_fence_full();
			__asm__ volatile("str %w0, [%1]" : : "r" (data), "r" (addr));
}
static inline __attribute__((always_inline)) uint64_t sys_read64(mem_addr_t=
 addr)
{
			uint64_t val;
			__asm__ volatile("ldr %x0, [%1]" : "=3Dr" (val) : "r" (addr));
			barrier_dmem_fence_full();
			return val;
}
static inline __attribute__((always_inline)) void sys_write64(uint64_t data=
, mem_addr_t addr)
{
			barrier_dmem_fence_full();
			__asm__ volatile("str %x0, [%1]" : : "r" (data), "r" (addr));
}
static inline __attribute__((always_inline)) void arm_arch_timer_init(void)
{
			extern int z_clock_hw_cycles_per_sec;
			uint64_t cntfrq_el0 =3D read_cntfrq_el0();
			{ };
			z_clock_hw_cycles_per_sec =3D (int) cntfrq_el0;
}
static inline __attribute__((always_inline)) void arm_arch_timer_set_compar=
e(uint64_t val)
{
			write_cntv_cval_el0(val);
}
static inline __attribute__((always_inline)) void arm_arch_timer_enable(uns=
igned char enable)
{
			uint64_t cntv_ctl;
			cntv_ctl =3D read_cntv_ctl_el0();
			if (enable) {
			cntv_ctl |=3D (1UL << (0));
			} else {
			cntv_ctl &=3D ~(1UL << (0));
			}
			write_cntv_ctl_el0(cntv_ctl);
}
static inline __attribute__((always_inline)) void arm_arch_timer_set_irq_ma=
sk(_Bool mask)
{
			uint64_t cntv_ctl;
			cntv_ctl =3D read_cntv_ctl_el0();
			if (mask) {
			cntv_ctl |=3D (1UL << (1));
			} else {
			cntv_ctl &=3D ~(1UL << (1));
			}
			write_cntv_ctl_el0(cntv_ctl);
}
static inline __attribute__((always_inline)) uint64_t arm_arch_timer_count(=
void)
{
			return read_cntvct_el0();
}
struct z_arm64_thread_stack_header {
			char privilege_stack[4096];
} __attribute__((__packed__)) __attribute__((__aligned__(16)));
typedef uintptr_t paddr_t;
typedef void *vaddr_t;
static inline __attribute__((always_inline)) void sys_set_bit(mem_addr_t ad=
dr, unsigned int bit)
{
			uint32_t temp =3D *(volatile uint32_t *)addr;
			*(volatile uint32_t *)addr =3D temp | (1 << bit);
}
static inline __attribute__((always_inline)) void sys_clear_bit(mem_addr_t =
addr, unsigned int bit)
{
			uint32_t temp =3D *(volatile uint32_t *)addr;
			*(volatile uint32_t *)addr =3D temp & ~(1 << bit);
}
static inline __attribute__((always_inline)) int sys_test_bit(mem_addr_t ad=
dr, unsigned int bit)
{
			uint32_t temp =3D *(volatile uint32_t *)addr;
			return temp & (1 << bit);
}
static inline __attribute__((always_inline)) void sys_set_bits(mem_addr_t a=
ddr, unsigned int mask)
{
			uint32_t temp =3D *(volatile uint32_t *)addr;
			*(volatile uint32_t *)addr =3D temp | mask;
}
static inline __attribute__((always_inline)) void sys_clear_bits(mem_addr_t=
 addr, unsigned int mask)
{
			uint32_t temp =3D *(volatile uint32_t *)addr;
			*(volatile uint32_t *)addr =3D temp & ~mask;
}
static inline __attribute__((always_inline))
			void sys_bitfield_set_bit(mem_addr_t addr, unsigned int bit)
{
			sys_set_bit(addr + ((bit >> 5) << 2), bit & 0x1F);
}
static inline __attribute__((always_inline))
			void sys_bitfield_clear_bit(mem_addr_t addr, unsigned int bit)
{
			sys_clear_bit(addr + ((bit >> 5) << 2), bit & 0x1F);
}
static inline __attribute__((always_inline))
			int sys_bitfield_test_bit(mem_addr_t addr, unsigned int bit)
{
			return sys_test_bit(addr + ((bit >> 5) << 2), bit & 0x1F);
}
static inline __attribute__((always_inline))
			int sys_test_and_set_bit(mem_addr_t addr, unsigned int bit)
{
			int ret;
			ret =3D sys_test_bit(addr, bit);
			sys_set_bit(addr, bit);
			return ret;
}
static inline __attribute__((always_inline))
			int sys_test_and_clear_bit(mem_addr_t addr, unsigned int bit)
{
			int ret;
			ret =3D sys_test_bit(addr, bit);
			sys_clear_bit(addr, bit);
			return ret;
}
static inline __attribute__((always_inline))
			int sys_bitfield_test_and_set_bit(mem_addr_t addr, unsigned int bit)
{
			int ret;
			ret =3D sys_bitfield_test_bit(addr, bit);
			sys_bitfield_set_bit(addr, bit);
			return ret;
}
static inline __attribute__((always_inline))
			int sys_bitfield_test_and_clear_bit(mem_addr_t addr, unsigned int bit)
{
			int ret;
			ret =3D sys_bitfield_test_bit(addr, bit);
			sys_bitfield_clear_bit(addr, bit);
			return ret;
}
static inline __attribute__((always_inline)) unsigned int find_msb_set(uint=
32_t op)
{
			if (op =3D=3D 0) {
			return 0;
			}
			return 32 - __builtin_clz(op);
}
static inline __attribute__((always_inline)) unsigned int find_lsb_set(uint=
32_t op)
{
			return __builtin_ffs(op);
}
struct arch_mem_domain {
			struct arm_mmu_ptables ptables;
			sys_snode_t node;
};
typedef int64_t k_ticks_t;
typedef struct {
			k_ticks_t ticks;
} k_timeout_t;
uint32_t sys_clock_tick_get_32(void);
int64_t sys_clock_tick_get(void);
typedef struct { uint64_t tick; } k_timepoint_t;
k_timepoint_t sys_timepoint_calc(k_timeout_t timeout);
k_timeout_t sys_timepoint_timeout(k_timepoint_t timepoint);
__attribute__((deprecated))
static inline uint64_t sys_clock_timeout_end_calc(k_timeout_t timeout)
{
			k_timepoint_t tp =3D sys_timepoint_calc(timeout);
			return tp.tick;
}
static inline int sys_timepoint_cmp(k_timepoint_t a, k_timepoint_t b)
{
			if (a.tick =3D=3D b.tick) {
			return 0;
			}
			return a.tick < b.tick ? -1 : 1;
}
static inline _Bool sys_timepoint_expired(k_timepoint_t timepoint)
{
			return ((sys_timepoint_timeout(timepoint)).ticks =3D=3D (((k_timeout_t) =
{0})).ticks);
}
extern int *__errno_location (void) __attribute__ ((__nothrow__ , __leaf__)=
) __attribute__ ((__const__));
struct z_spinlock_key {
			int key;
};
struct k_spinlock {
};
typedef struct z_spinlock_key k_spinlock_key_t;
static inline __attribute__((always_inline)) void z_spinlock_validate_pre(s=
truct k_spinlock *l)
{
			(void)(l);
}
static inline __attribute__((always_inline)) void z_spinlock_validate_post(=
struct k_spinlock *l)
{
			(void)(l);
}
static inline __attribute__((always_inline)) k_spinlock_key_t k_spin_lock(s=
truct k_spinlock *l)
{
			(void)(l);
			k_spinlock_key_t k;
			k.key =3D arch_irq_lock();
			z_spinlock_validate_pre(l);
			z_spinlock_validate_post(l);
			return k;
}
static inline __attribute__((always_inline)) int k_spin_trylock(struct k_sp=
inlock *l, k_spinlock_key_t *k)
{
			int key =3D arch_irq_lock();
			z_spinlock_validate_pre(l);
			z_spinlock_validate_post(l);
			k->key =3D key;
			return 0;
}
static inline __attribute__((always_inline)) void k_spin_unlock(struct k_sp=
inlock *l,
			k_spinlock_key_t key)
{
			(void)(l);
			arch_irq_unlock(key.key);
}
static inline __attribute__((always_inline)) void k_spin_release(struct k_s=
pinlock *l)
{
			(void)(l);
}
enum k_fatal_error_reason {
			K_ERR_CPU_EXCEPTION,
			K_ERR_SPURIOUS_IRQ,
			K_ERR_STACK_CHK_FAIL,
			K_ERR_KERNEL_OOPS,
			K_ERR_KERNEL_PANIC,
			K_ERR_ARCH_START =3D 16
};
__attribute__((__noreturn__)) void k_fatal_halt(unsigned int reason);
void k_sys_fatal_error_handler(unsigned int reason, const z_arch_esf_t *esf=
);
void z_fatal_error(unsigned int reason, const z_arch_esf_t *esf);
struct __attribute__((__packed__)) z_thread_stack_element {
			char data;
};
static inline char *z_stack_ptr_align(char *ptr)
{
			return (char *)(((unsigned long)(ptr) / (unsigned long)(16)) * (unsigned=
 long)(16));
}
static inline char *Z_KERNEL_STACK_BUFFER(k_thread_stack_t *sym)
{
			return (char *)sym + ((size_t)0);
}
struct k_thread;
struct _pipe_desc {
			sys_dnode_t node;
			unsigned char *buffer;
			size_t bytes_to_xfer;
			struct k_thread *thread;
};
struct _thread_base {
			union {
			sys_dnode_t qnode_dlist;
			struct rbnode qnode_rb;
			};
			_wait_q_t *pended_on;
			uint8_t user_options;
			uint8_t thread_state;
			union {
			struct {
			int8_t prio;
			uint8_t sched_locked;
			};
			uint16_t preempt;
			};
			uint32_t order_key;
			void *swap_data;
			struct _timeout timeout;
};
typedef struct _thread_base _thread_base_t;
typedef struct k_thread_runtime_stats {
} k_thread_runtime_stats_t;
struct z_poller {
			_Bool is_polling;
			uint8_t mode;
};
struct k_thread {
			struct _thread_base base;
			struct _callee_saved callee_saved;
			void *init_data;
			_wait_q_t join_queue;
			int swap_retval;
			void *switch_handle;
			struct k_heap *resource_pool;
			uintptr_t tls;
			struct _thread_arch arch;
};
typedef struct k_thread _thread_t;
typedef struct k_thread *k_tid_t;
struct k_mem_domain;
struct k_mem_partition;
extern int k_mem_domain_init(struct k_mem_domain *domain, uint8_t num_parts=
,
			struct k_mem_partition *parts[]);
extern int k_mem_domain_add_partition(struct k_mem_domain *domain,
			struct k_mem_partition *part);
extern int k_mem_domain_remove_partition(struct k_mem_domain *domain,
			struct k_mem_partition *part);
extern int k_mem_domain_add_thread(struct k_mem_domain *domain,
			k_tid_t thread);
static inline void k_object_init(const void *obj)
{
			(void)(obj);
}
static inline struct k_object *k_object_create_dynamic_aligned(size_t align=
,
			size_t size)
{
			(void)(align);
			(void)(size);
			return ((void *)0);
}
static inline struct k_object *k_object_create_dynamic(size_t size)
{
			(void)(size);
			return ((void *)0);
}
struct k_thread;
struct k_mutex;
struct z_futex_data;
enum k_objects {
			K_OBJ_ANY,
K_OBJ_MEM_SLAB,
K_OBJ_MSGQ,
K_OBJ_MUTEX,
K_OBJ_PIPE,
K_OBJ_QUEUE,
K_OBJ_POLL_SIGNAL,
K_OBJ_SEM,
K_OBJ_STACK,
K_OBJ_THREAD,
K_OBJ_TIMER,
K_OBJ_THREAD_STACK_ELEMENT,
K_OBJ_NET_SOCKET,
K_OBJ_NET_IF,
K_OBJ_SYS_MUTEX,
K_OBJ_FUTEX,
K_OBJ_CONDVAR,
K_OBJ_DRIVER_UART,
K_OBJ_DRIVER_CRYPTO,
K_OBJ_DRIVER_ADC,
K_OBJ_DRIVER_AUXDISPLAY,
K_OBJ_DRIVER_BBRAM,
K_OBJ_DRIVER_CAN,
K_OBJ_DRIVER_CHARGER,
K_OBJ_DRIVER_COREDUMP,
K_OBJ_DRIVER_COUNTER,
K_OBJ_DRIVER_DAC,
K_OBJ_DRIVER_DAI,
K_OBJ_DRIVER_DMA,
K_OBJ_DRIVER_EDAC,
K_OBJ_DRIVER_EEPROM,
K_OBJ_DRIVER_FUEL_GAUGE_EMUL,
K_OBJ_DRIVER_EMUL_SENSOR_BACKEND_API,
K_OBJ_DRIVER_ENTROPY,
K_OBJ_DRIVER_ESPI,
K_OBJ_DRIVER_ESPI_SAF,
K_OBJ_DRIVER_FLASH,
K_OBJ_DRIVER_FPGA,
K_OBJ_DRIVER_FUEL_GAUGE,
K_OBJ_DRIVER_GNSS,
K_OBJ_DRIVER_GPIO,
K_OBJ_DRIVER_HWSPINLOCK,
K_OBJ_DRIVER_I2C,
K_OBJ_DRIVER_I2S,
K_OBJ_DRIVER_I3C,
K_OBJ_DRIVER_IPM,
K_OBJ_DRIVER_KSCAN,
K_OBJ_DRIVER_LED,
K_OBJ_DRIVER_MBOX,
K_OBJ_DRIVER_MDIO,
K_OBJ_DRIVER_MIPI_DSI,
K_OBJ_DRIVER_PECI,
K_OBJ_DRIVER_PS2,
K_OBJ_DRIVER_PTP_CLOCK,
K_OBJ_DRIVER_PWM,
K_OBJ_DRIVER_REGULATOR_PARENT,
K_OBJ_DRIVER_REGULATOR,
K_OBJ_DRIVER_RESET,
K_OBJ_DRIVER_RETAINED_MEM,
K_OBJ_DRIVER_RTC,
K_OBJ_DRIVER_SDHC,
K_OBJ_DRIVER_SENSOR,
K_OBJ_DRIVER_SMBUS,
K_OBJ_DRIVER_SPI,
K_OBJ_DRIVER_SYSCON,
K_OBJ_DRIVER_W1,
K_OBJ_DRIVER_WDT,
K_OBJ_DRIVER_CAN_TRANSCEIVER,
K_OBJ_DRIVER_UART_MUX,
K_OBJ_DRIVER_ITS,
K_OBJ_DRIVER_TGPIO,
K_OBJ_DRIVER_PCIE_CTRL,
K_OBJ_DRIVER_SVC,
K_OBJ_DRIVER_BC12_EMUL,
K_OBJ_DRIVER_BC12,
K_OBJ_DRIVER_TCPC,
K_OBJ_DRIVER_IVSHMEM,
K_OBJ_DRIVER_EC_HOST_CMD_BACKEND_API,
K_OBJ_DRIVER_ETHPHY,
			K_OBJ_LAST
};
static inline void z_impl_k_object_access_grant(const void *object,
			struct k_thread *thread)
{
			(void)(object);
			(void)(thread);
}
static inline void k_object_access_revoke(const void *object,
			struct k_thread *thread)
{
			(void)(object);
			(void)(thread);
}
static inline void z_impl_k_object_release(const void *object)
{
			(void)(object);
}
static inline void k_object_access_all_grant(const void *object)
{
			(void)(object);
}
static inline _Bool k_object_is_valid(const void *obj, enum k_objects otype=
)
{
			(void)(obj);
			(void)(otype);
			return 1;
}
static inline void *z_impl_k_object_alloc(enum k_objects otype)
{
			(void)(otype);
			return ((void *)0);
}
static inline void *z_impl_k_object_alloc_size(enum k_objects otype,
			size_t size)
{
			(void)(otype);
			(void)(size);
			return ((void *)0);
}
static inline void k_object_free(void *obj)
{
			(void)(obj);
}
extern void z_impl_k_object_access_grant(const void * object, struct k_thre=
ad * thread);
static inline void k_object_access_grant(const void * object, struct k_thre=
ad * thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_object_access_grant(object, thread);
}
extern void z_impl_k_object_release(const void * object);
static inline void k_object_release(const void * object)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_object_release(object);
}
extern void * z_impl_k_object_alloc(enum k_objects otype);
static inline void * k_object_alloc(enum k_objects otype)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_object_alloc(otype);
}
extern void * z_impl_k_object_alloc_size(enum k_objects otype, size_t size)=
;
static inline void * k_object_alloc_size(enum k_objects otype, size_t size)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_object_alloc_size(otype, size);
}
struct k_thread;
void z_init_cpu(int id);
void z_sched_ipi(void);
void z_smp_start_cpu(int id);
extern int (*__Static_assert_function (void)) [!!sizeof (struct { int __err=
or_if_negative: (sizeof(int32_t) =3D=3D sizeof(int)) ? 2 : -1; })];
extern int (*__Static_assert_function (void)) [!!sizeof (struct { int __err=
or_if_negative: (sizeof(int64_t) =3D=3D sizeof(long long)) ? 2 : -1; })];
extern int (*__Static_assert_function (void)) [!!sizeof (struct { int __err=
or_if_negative: (sizeof(intptr_t) =3D=3D sizeof(long)) ? 2 : -1; })];
struct k_thread;
struct k_mutex;
struct k_sem;
struct k_msgq;
struct k_mbox;
struct k_pipe;
struct k_queue;
struct k_fifo;
struct k_lifo;
struct k_stack;
struct k_mem_slab;
struct k_timer;
struct k_poll_event;
struct k_poll_signal;
struct k_mem_domain;
struct k_mem_partition;
struct k_futex;
struct k_event;
enum execution_context_types {
			K_ISR =3D 0,
			K_COOP_THREAD,
			K_PREEMPT_THREAD,
};
struct k_work_poll;
typedef int (*_poller_cb_t)(struct k_poll_event *event, uint32_t state);
typedef void (*k_thread_user_cb_t)(const struct k_thread *thread,
			void *user_data);
void k_thread_foreach(k_thread_user_cb_t user_cb, void *user_data);
void k_thread_foreach_unlocked(
			k_thread_user_cb_t user_cb, void *user_data);
static inline k_thread_stack_t *k_thread_stack_alloc(size_t size, int flags=
);
static inline int k_thread_stack_free(k_thread_stack_t *stack);
static inline k_tid_t k_thread_create(struct k_thread *new_thread,
			k_thread_stack_t *stack,
			size_t stack_size,
			k_thread_entry_t entry,
			void *p1, void *p2, void *p3,
			int prio, uint32_t options, k_timeout_t delay);
__attribute__((__noreturn__)) void k_thread_user_mode_enter(k_thread_entry_=
t entry,
			void *p1, void *p2,
			void *p3);
static inline void k_thread_heap_assign(struct k_thread *thread,
			struct k_heap *heap)
{
			thread->resource_pool =3D heap;
}
static inline int k_thread_join(struct k_thread *thread, k_timeout_t timeou=
t);
static inline int32_t k_sleep(k_timeout_t timeout);
static inline int32_t k_msleep(int32_t ms)
{
			return k_sleep(((k_timeout_t) { .ticks =3D ((k_ticks_t)((1) ? ( ((10000)=
 =3D=3D (1000)) ? (uint64_t) ((((ms) > (0)) ? (ms) : (0))) : ((1000) > (100=
00) && (1000) % (10000) =3D=3D 0U) ? (((uint64_t) ((((ms) > (0)) ? (ms) : (=
0))) + ((0) ? ((1000) / (10000)) / 2 : (1) ? ((1000) / (10000)) - 1 : 0)) /=
 ((1000)/(10000) ? (1000)/(10000) : 01u)) : ((10000) > (1000) && (10000) % =
(1000) =3D=3D 0U) ? (uint64_t) ((((ms) > (0)) ? (ms) : (0)))*((10000) / (10=
00)) : ((((((365 * 24ULL * 3600ULL * 1000) + ((4294967295U)) - 1) / ((42949=
67295U))) * 10000) <=3D (4294967295U)) ? (((uint64_t) ((((ms) > (0)) ? (ms)=
 : (0)))*(10000) + ((0) ? (1000) / 2 : (1) ? (1000) - 1 : 0)) / (1000)) : (=
((uint64_t) ((((ms) > (0)) ? (ms) : (0))) / (1000))*(10000) + (((uint64_t) =
((((ms) > (0)) ? (ms) : (0))) % (1000))*(10000) + ((0) ? (1000) / 2 : (1) ?=
 (1000) - 1 : 0)) / (1000))) ) : (((uint64_t) ((((ms) > (0)) ? (ms) : (0)))=
 / (1000))*(10000) + (((uint64_t) ((((ms) > (0)) ? (ms) : (0))) % (1000))*(=
10000) + ((0) ? (1000) / 2 : (1) ? (1000) - 1 : 0)) / (1000)) )) }));
}
static inline int32_t k_usleep(int32_t us);
static inline void k_busy_wait(uint32_t usec_to_wait);
_Bool k_can_yield(void);
static inline void k_yield(void);
static inline void k_wakeup(k_tid_t thread);
__attribute__ ((__const__))
static inline k_tid_t k_sched_current_thread_query(void);
__attribute__ ((__const__))
static inline k_tid_t k_current_get(void)
{
			extern __thread k_tid_t z_tls_current;
			return z_tls_current;
}
static inline void k_thread_abort(k_tid_t thread);
static inline void k_thread_start(k_tid_t thread);
k_ticks_t z_timeout_expires(const struct _timeout *timeout);
k_ticks_t z_timeout_remaining(const struct _timeout *timeout);
static inline k_ticks_t k_thread_timeout_expires_ticks(const struct k_threa=
d *t);
static inline k_ticks_t z_impl_k_thread_timeout_expires_ticks(
			const struct k_thread *t)
{
			return z_timeout_expires(&t->base.timeout);
}
static inline k_ticks_t k_thread_timeout_remaining_ticks(const struct k_thr=
ead *t);
static inline k_ticks_t z_impl_k_thread_timeout_remaining_ticks(
			const struct k_thread *t)
{
			return z_timeout_remaining(&t->base.timeout);
}
struct _static_thread_data {
			struct k_thread *init_thread;
			k_thread_stack_t *init_stack;
			unsigned int init_stack_size;
			k_thread_entry_t init_entry;
			void *init_p1;
			void *init_p2;
			void *init_p3;
			int init_prio;
			uint32_t init_options;
			const char *init_name;
			int32_t init_delay_ms;
};
static inline int k_thread_priority_get(k_tid_t thread);
static inline void k_thread_priority_set(k_tid_t thread, int prio);
static inline void k_thread_suspend(k_tid_t thread);
static inline void k_thread_resume(k_tid_t thread);
void k_sched_time_slice_set(int32_t slice, int prio);
void k_thread_time_slice_set(struct k_thread *th, int32_t slice_ticks,
			k_thread_timeslice_fn_t expired, void *data);
_Bool k_is_in_isr(void);
static inline int k_is_preempt_thread(void);
static inline _Bool k_is_pre_kernel(void)
{
			extern _Bool z_sys_post_kernel;
			return !z_sys_post_kernel;
}
void k_sched_lock(void);
void k_sched_unlock(void);
static inline void k_thread_custom_data_set(void *value);
static inline void *k_thread_custom_data_get(void);
static inline int k_thread_name_set(k_tid_t thread, const char *str);
const char *k_thread_name_get(k_tid_t thread);
static inline int k_thread_name_copy(k_tid_t thread, char *buf,
			size_t size);
const char *k_thread_state_str(k_tid_t thread_id, char *buf, size_t buf_siz=
e);
struct k_timer {
			struct _timeout timeout;
			_wait_q_t wait_q;
			void (*expiry_fn)(struct k_timer *timer);
			void (*stop_fn)(struct k_timer *timer);
			k_timeout_t period;
			uint32_t status;
			void *user_data;
};
typedef void (*k_timer_expiry_t)(struct k_timer *timer);
typedef void (*k_timer_stop_t)(struct k_timer *timer);
void k_timer_init(struct k_timer *timer,
			k_timer_expiry_t expiry_fn,
			k_timer_stop_t stop_fn);
static inline void k_timer_start(struct k_timer *timer,
			k_timeout_t duration, k_timeout_t period);
static inline void k_timer_stop(struct k_timer *timer);
static inline uint32_t k_timer_status_get(struct k_timer *timer);
static inline uint32_t k_timer_status_sync(struct k_timer *timer);
static inline k_ticks_t k_timer_expires_ticks(const struct k_timer *timer);
static inline k_ticks_t z_impl_k_timer_expires_ticks(
			const struct k_timer *timer)
{
			return z_timeout_expires(&timer->timeout);
}
static inline k_ticks_t k_timer_remaining_ticks(const struct k_timer *timer=
);
static inline k_ticks_t z_impl_k_timer_remaining_ticks(
			const struct k_timer *timer)
{
			return z_timeout_remaining(&timer->timeout);
}
static inline uint32_t k_timer_remaining_get(struct k_timer *timer)
{
			return ((1) ? ( ((1000) =3D=3D (10000)) ? (uint32_t) (k_timer_remaining_=
ticks(timer)) : ((10000) > (1000) && (10000) % (1000) =3D=3D 0U) ? ((uint64=
_t) (k_timer_remaining_ticks(timer)) <=3D 0xffffffffU - ((0) ? ((10000) / (=
1000)) / 2 : (0) ? ((10000) / (1000)) - 1 : 0) ? ((uint32_t)((k_timer_remai=
ning_ticks(timer)) + ((0) ? ((10000) / (1000)) / 2 : (0) ? ((10000) / (1000=
)) - 1 : 0)) / ((10000)/(1000) ? (10000)/(1000) : 01u)) : (uint32_t) (((uin=
t64_t) (k_timer_remaining_ticks(timer)) + ((0) ? ((10000) / (1000)) / 2 : (=
0) ? ((10000) / (1000)) - 1 : 0)) / ((10000)/(1000) ? (10000)/(1000) : 01u)=
) ) : ((1000) > (10000) && (1000) % (10000) =3D=3D 0U) ? (uint32_t) (k_time=
r_remaining_ticks(timer))*((1000) / (10000)) : ((uint32_t) (((uint64_t) (k_=
timer_remaining_ticks(timer))*(1000) + ((0) ? (10000) / 2 : (0) ? (10000) -=
 1 : 0)) / (10000))) ) : ((uint32_t) (((uint64_t) (k_timer_remaining_ticks(=
timer))*(1000) + ((0) ? (10000) / 2 : (0) ? (10000) - 1 : 0)) / (10000))) )=
;
}
static inline void k_timer_user_data_set(struct k_timer *timer, void *user_=
data);
static inline void z_impl_k_timer_user_data_set(struct k_timer *timer,
			void *user_data)
{
			timer->user_data =3D user_data;
}
static inline void *k_timer_user_data_get(const struct k_timer *timer);
static inline void *z_impl_k_timer_user_data_get(const struct k_timer *time=
r)
{
			return timer->user_data;
}
static inline int64_t k_uptime_ticks(void);
static inline int64_t k_uptime_get(void)
{
			return ((1) ? ( ((1000) =3D=3D (10000)) ? (uint64_t) (k_uptime_ticks()) =
: ((10000) > (1000) && (10000) % (1000) =3D=3D 0U) ? (((uint64_t) (k_uptime=
_ticks()) + ((0) ? ((10000) / (1000)) / 2 : (0) ? ((10000) / (1000)) - 1 : =
0)) / ((10000)/(1000) ? (10000)/(1000) : 01u)) : ((1000) > (10000) && (1000=
) % (10000) =3D=3D 0U) ? (uint64_t) (k_uptime_ticks())*((1000) / (10000)) :=
 ((((((365 * 24ULL * 3600ULL * 10000) + ((4294967295U)) - 1) / ((4294967295=
U))) * 1000) <=3D (4294967295U)) ? (((uint64_t) (k_uptime_ticks())*(1000) +=
 ((0) ? (10000) / 2 : (0) ? (10000) - 1 : 0)) / (10000)) : (((uint64_t) (k_=
uptime_ticks()) / (10000))*(1000) + (((uint64_t) (k_uptime_ticks()) % (1000=
0))*(1000) + ((0) ? (10000) / 2 : (0) ? (10000) - 1 : 0)) / (10000))) ) : (=
((uint64_t) (k_uptime_ticks()) / (10000))*(1000) + (((uint64_t) (k_uptime_t=
icks()) % (10000))*(1000) + ((0) ? (10000) / 2 : (0) ? (10000) - 1 : 0)) / =
(10000)) );
}
static inline uint32_t k_uptime_get_32(void)
{
			return (uint32_t)k_uptime_get();
}
static inline int64_t k_uptime_delta(int64_t *reftime)
{
			int64_t uptime, delta;
			uptime =3D k_uptime_get();
			delta =3D uptime - *reftime;
			*reftime =3D uptime;
			return delta;
}
static inline uint32_t k_cycle_get_32(void)
{
			return arch_k_cycle_get_32();
}
static inline uint64_t k_cycle_get_64(void)
{
			if (!1) {
			{ };
			return 0;
			}
			return arch_k_cycle_get_64();
}
struct k_queue {
			sys_sflist_t data_q;
			struct k_spinlock lock;
			_wait_q_t wait_q;
};
static inline void k_queue_init(struct k_queue *queue);
static inline void k_queue_cancel_wait(struct k_queue *queue);
void k_queue_append(struct k_queue *queue, void *data);
static inline int32_t k_queue_alloc_append(struct k_queue *queue, void *dat=
a);
void k_queue_prepend(struct k_queue *queue, void *data);
static inline int32_t k_queue_alloc_prepend(struct k_queue *queue, void *da=
ta);
void k_queue_insert(struct k_queue *queue, void *prev, void *data);
int k_queue_append_list(struct k_queue *queue, void *head, void *tail);
int k_queue_merge_slist(struct k_queue *queue, sys_slist_t *list);
static inline void *k_queue_get(struct k_queue *queue, k_timeout_t timeout)=
;
_Bool k_queue_remove(struct k_queue *queue, void *data);
_Bool k_queue_unique_append(struct k_queue *queue, void *data);
static inline int k_queue_is_empty(struct k_queue *queue);
static inline int z_impl_k_queue_is_empty(struct k_queue *queue)
{
			return (int)sys_sflist_is_empty(&queue->data_q);
}
static inline void *k_queue_peek_head(struct k_queue *queue);
static inline void *k_queue_peek_tail(struct k_queue *queue);
struct k_event {
			_wait_q_t wait_q;
			uint32_t events;
			struct k_spinlock lock;
};
static inline void k_event_init(struct k_event *event);
static inline uint32_t k_event_post(struct k_event *event, uint32_t events)=
;
static inline uint32_t k_event_set(struct k_event *event, uint32_t events);
static inline uint32_t k_event_set_masked(struct k_event *event, uint32_t e=
vents,
			uint32_t events_mask);
static inline uint32_t k_event_clear(struct k_event *event, uint32_t events=
);
static inline uint32_t k_event_wait(struct k_event *event, uint32_t events,
			_Bool reset, k_timeout_t timeout);
static inline uint32_t k_event_wait_all(struct k_event *event, uint32_t eve=
nts,
			_Bool reset, k_timeout_t timeout);
static inline uint32_t k_event_test(struct k_event *event, uint32_t events_=
mask)
{
			return k_event_wait(event, events_mask, 0, ((k_timeout_t) {0}));
}
struct k_fifo {
			struct k_queue _queue;
};
struct k_lifo {
			struct k_queue _queue;
};
typedef uintptr_t stack_data_t;
struct k_stack {
			_wait_q_t wait_q;
			struct k_spinlock lock;
			stack_data_t *base, *next, *top;
			uint8_t flags;
};
void k_stack_init(struct k_stack *stack,
			stack_data_t *buffer, uint32_t num_entries);
static inline int32_t k_stack_alloc_init(struct k_stack *stack,
			uint32_t num_entries);
int k_stack_cleanup(struct k_stack *stack);
static inline int k_stack_push(struct k_stack *stack, stack_data_t data);
static inline int k_stack_pop(struct k_stack *stack, stack_data_t *data,
			k_timeout_t timeout);
struct k_work;
struct k_work_q;
struct k_work_queue_config;
extern struct k_work_q k_sys_work_q;
struct k_mutex {
			_wait_q_t wait_q;
			struct k_thread *owner;
			uint32_t lock_count;
			int owner_orig_prio;
};
static inline int k_mutex_init(struct k_mutex *mutex);
static inline int k_mutex_lock(struct k_mutex *mutex, k_timeout_t timeout);
static inline int k_mutex_unlock(struct k_mutex *mutex);
struct k_condvar {
			_wait_q_t wait_q;
};
static inline int k_condvar_init(struct k_condvar *condvar);
static inline int k_condvar_signal(struct k_condvar *condvar);
static inline int k_condvar_broadcast(struct k_condvar *condvar);
static inline int k_condvar_wait(struct k_condvar *condvar, struct k_mutex =
*mutex,
			k_timeout_t timeout);
struct k_sem {
			_wait_q_t wait_q;
			unsigned int count;
			unsigned int limit;
};
static inline int k_sem_init(struct k_sem *sem, unsigned int initial_count,
			unsigned int limit);
static inline int k_sem_take(struct k_sem *sem, k_timeout_t timeout);
static inline void k_sem_give(struct k_sem *sem);
static inline void k_sem_reset(struct k_sem *sem);
static inline unsigned int k_sem_count_get(struct k_sem *sem);
static inline unsigned int z_impl_k_sem_count_get(struct k_sem *sem)
{
			return sem->count;
}
struct k_work_delayable;
struct k_work_sync;
typedef void (*k_work_handler_t)(struct k_work *work);
void k_work_init(struct k_work *work,
			k_work_handler_t handler);
int k_work_busy_get(const struct k_work *work);
static inline _Bool k_work_is_pending(const struct k_work *work);
int k_work_submit_to_queue(struct k_work_q *queue,
			struct k_work *work);
int k_work_submit(struct k_work *work);
_Bool k_work_flush(struct k_work *work,
			struct k_work_sync *sync);
int k_work_cancel(struct k_work *work);
_Bool k_work_cancel_sync(struct k_work *work, struct k_work_sync *sync);
void k_work_queue_init(struct k_work_q *queue);
void k_work_queue_start(struct k_work_q *queue,
			k_thread_stack_t *stack, size_t stack_size,
			int prio, const struct k_work_queue_config *cfg);
static inline k_tid_t k_work_queue_thread_get(struct k_work_q *queue);
int k_work_queue_drain(struct k_work_q *queue, _Bool plug);
int k_work_queue_unplug(struct k_work_q *queue);
void k_work_init_delayable(struct k_work_delayable *dwork,
			k_work_handler_t handler);
static inline struct k_work_delayable *
k_work_delayable_from_work(struct k_work *work);
int k_work_delayable_busy_get(const struct k_work_delayable *dwork);
static inline _Bool k_work_delayable_is_pending(
			const struct k_work_delayable *dwork);
static inline k_ticks_t k_work_delayable_expires_get(
			const struct k_work_delayable *dwork);
static inline k_ticks_t k_work_delayable_remaining_get(
			const struct k_work_delayable *dwork);
int k_work_schedule_for_queue(struct k_work_q *queue,
			struct k_work_delayable *dwork,
			k_timeout_t delay);
int k_work_schedule(struct k_work_delayable *dwork,
			k_timeout_t delay);
int k_work_reschedule_for_queue(struct k_work_q *queue,
			struct k_work_delayable *dwork,
			k_timeout_t delay);
int k_work_reschedule(struct k_work_delayable *dwork,
			k_timeout_t delay);
_Bool k_work_flush_delayable(struct k_work_delayable *dwork,
			struct k_work_sync *sync);
int k_work_cancel_delayable(struct k_work_delayable *dwork);
_Bool k_work_cancel_delayable_sync(struct k_work_delayable *dwork,
			struct k_work_sync *sync);
enum {
			K_WORK_RUNNING_BIT =3D 0,
			K_WORK_CANCELING_BIT =3D 1,
			K_WORK_QUEUED_BIT =3D 2,
			K_WORK_DELAYED_BIT =3D 3,
			K_WORK_MASK =3D (1UL << (K_WORK_DELAYED_BIT)) | (1UL << (K_WORK_QUEUED_B=
IT))
			| (1UL << (K_WORK_RUNNING_BIT)) | (1UL << (K_WORK_CANCELING_BIT)),
			K_WORK_DELAYABLE_BIT =3D 8,
			K_WORK_DELAYABLE =3D (1UL << (K_WORK_DELAYABLE_BIT)),
			K_WORK_QUEUE_STARTED_BIT =3D 0,
			K_WORK_QUEUE_STARTED =3D (1UL << (K_WORK_QUEUE_STARTED_BIT)),
			K_WORK_QUEUE_BUSY_BIT =3D 1,
			K_WORK_QUEUE_BUSY =3D (1UL << (K_WORK_QUEUE_BUSY_BIT)),
			K_WORK_QUEUE_DRAIN_BIT =3D 2,
			K_WORK_QUEUE_DRAIN =3D (1UL << (K_WORK_QUEUE_DRAIN_BIT)),
			K_WORK_QUEUE_PLUGGED_BIT =3D 3,
			K_WORK_QUEUE_PLUGGED =3D (1UL << (K_WORK_QUEUE_PLUGGED_BIT)),
			K_WORK_QUEUE_NO_YIELD_BIT =3D 8,
			K_WORK_QUEUE_NO_YIELD =3D (1UL << (K_WORK_QUEUE_NO_YIELD_BIT)),
			K_WORK_RUNNING =3D (1UL << (K_WORK_RUNNING_BIT)),
			K_WORK_CANCELING =3D (1UL << (K_WORK_CANCELING_BIT)),
			K_WORK_QUEUED =3D (1UL << (K_WORK_QUEUED_BIT)),
			K_WORK_DELAYED =3D (1UL << (K_WORK_DELAYED_BIT)),
};
struct k_work {
			sys_snode_t node;
			k_work_handler_t handler;
			struct k_work_q *queue;
			uint32_t flags;
};
struct k_work_delayable {
			struct k_work work;
			struct _timeout timeout;
			struct k_work_q *queue;
};
struct z_work_flusher {
			struct k_work work;
			struct k_sem sem;
};
struct z_work_canceller {
			sys_snode_t node;
			struct k_work *work;
			struct k_sem sem;
};
struct k_work_sync {
			union {
			struct z_work_flusher flusher;
			struct z_work_canceller canceller;
			};
};
struct k_work_queue_config {
			const char *name;
			_Bool no_yield;
};
struct k_work_q {
			struct k_thread thread;
			sys_slist_t pending;
			_wait_q_t notifyq;
			_wait_q_t drainq;
			uint32_t flags;
};
static inline _Bool k_work_is_pending(const struct k_work *work)
{
			return k_work_busy_get(work) !=3D 0;
}
static inline struct k_work_delayable *
k_work_delayable_from_work(struct k_work *work)
{
			return ({ extern int (*__Static_assert_function (void)) [!!sizeof (struc=
t { int __error_if_negative: (__builtin_types_compatible_p(__typeof__(*(wor=
k)), __typeof__(((struct k_work_delayable *)0)->work)) || __builtin_types_c=
ompatible_p(__typeof__(*(work)), __typeof__(void))) ? 2 : -1; })]; ((struct=
 k_work_delayable *)(((char *)(work)) - __builtin_offsetof (struct k_work_d=
elayable, work))); });
}
static inline _Bool k_work_delayable_is_pending(
			const struct k_work_delayable *dwork)
{
			return k_work_delayable_busy_get(dwork) !=3D 0;
}
static inline k_ticks_t k_work_delayable_expires_get(
			const struct k_work_delayable *dwork)
{
			return z_timeout_expires(&dwork->timeout);
}
static inline k_ticks_t k_work_delayable_remaining_get(
			const struct k_work_delayable *dwork)
{
			return z_timeout_remaining(&dwork->timeout);
}
static inline k_tid_t k_work_queue_thread_get(struct k_work_q *queue)
{
			return &queue->thread;
}
struct k_work_user;
typedef void (*k_work_user_handler_t)(struct k_work_user *work);
struct k_work_user_q {
			struct k_queue queue;
			struct k_thread thread;
};
enum {
			K_WORK_USER_STATE_PENDING,
};
struct k_work_user {
			void *_reserved;
			k_work_user_handler_t handler;
			atomic_t flags;
};
static inline void k_work_user_init(struct k_work_user *work,
			k_work_user_handler_t handler)
{
			*work =3D (struct k_work_user){ ._reserved =3D ((void *)0), .handler =3D=
 handler, .flags =3D 0 };
}
static inline _Bool k_work_user_is_pending(struct k_work_user *work)
{
			return atomic_test_bit(&work->flags, K_WORK_USER_STATE_PENDING);
}
static inline int k_work_user_submit_to_queue(struct k_work_user_q *work_q,
			struct k_work_user *work)
{
			int ret =3D -16;
			if (!atomic_test_and_set_bit(&work->flags,
			K_WORK_USER_STATE_PENDING)) {
			ret =3D k_queue_alloc_append(&work_q->queue, work);
			if (ret !=3D 0) {
			atomic_clear_bit(&work->flags,
			K_WORK_USER_STATE_PENDING);
			}
			}
			return ret;
}
void k_work_user_queue_start(struct k_work_user_q *work_q,
			k_thread_stack_t *stack,
			size_t stack_size, int prio,
			const char *name);
static inline k_tid_t k_work_user_queue_thread_get(struct k_work_user_q *wo=
rk_q)
{
			return &work_q->thread;
}
struct k_work_poll {
			struct k_work work;
			struct k_work_q *workq;
			struct z_poller poller;
			struct k_poll_event *events;
			int num_events;
			k_work_handler_t real_handler;
			struct _timeout timeout;
			int poll_result;
};
void k_work_poll_init(struct k_work_poll *work,
			k_work_handler_t handler);
int k_work_poll_submit_to_queue(struct k_work_q *work_q,
			struct k_work_poll *work,
			struct k_poll_event *events,
			int num_events,
			k_timeout_t timeout);
int k_work_poll_submit(struct k_work_poll *work,
			struct k_poll_event *events,
			int num_events,
			k_timeout_t timeout);
int k_work_poll_cancel(struct k_work_poll *work);
struct k_msgq {
			_wait_q_t wait_q;
			struct k_spinlock lock;
			size_t msg_size;
			uint32_t max_msgs;
			char *buffer_start;
			char *buffer_end;
			char *read_ptr;
			char *write_ptr;
			uint32_t used_msgs;
			uint8_t flags;
};
struct k_msgq_attrs {
			size_t msg_size;
			uint32_t max_msgs;
			uint32_t used_msgs;
};
void k_msgq_init(struct k_msgq *msgq, char *buffer, size_t msg_size,
			uint32_t max_msgs);
static inline int k_msgq_alloc_init(struct k_msgq *msgq, size_t msg_size,
			uint32_t max_msgs);
int k_msgq_cleanup(struct k_msgq *msgq);
static inline int k_msgq_put(struct k_msgq *msgq, const void *data, k_timeo=
ut_t timeout);
static inline int k_msgq_get(struct k_msgq *msgq, void *data, k_timeout_t t=
imeout);
static inline int k_msgq_peek(struct k_msgq *msgq, void *data);
static inline int k_msgq_peek_at(struct k_msgq *msgq, void *data, uint32_t =
idx);
static inline void k_msgq_purge(struct k_msgq *msgq);
static inline uint32_t k_msgq_num_free_get(struct k_msgq *msgq);
static inline void k_msgq_get_attrs(struct k_msgq *msgq,
			struct k_msgq_attrs *attrs);
static inline uint32_t z_impl_k_msgq_num_free_get(struct k_msgq *msgq)
{
			return msgq->max_msgs - msgq->used_msgs;
}
static inline uint32_t k_msgq_num_used_get(struct k_msgq *msgq);
static inline uint32_t z_impl_k_msgq_num_used_get(struct k_msgq *msgq)
{
			return msgq->used_msgs;
}
struct k_mbox_msg {
			size_t size;
			uint32_t info;
			void *tx_data;
			k_tid_t rx_source_thread;
			k_tid_t tx_target_thread;
			k_tid_t _syncing_thread;
			struct k_sem *_async_sem;
};
struct k_mbox {
			_wait_q_t tx_msg_queue;
			_wait_q_t rx_msg_queue;
			struct k_spinlock lock;
};
void k_mbox_init(struct k_mbox *mbox);
int k_mbox_put(struct k_mbox *mbox, struct k_mbox_msg *tx_msg,
			k_timeout_t timeout);
void k_mbox_async_put(struct k_mbox *mbox, struct k_mbox_msg *tx_msg,
			struct k_sem *sem);
int k_mbox_get(struct k_mbox *mbox, struct k_mbox_msg *rx_msg,
			void *buffer, k_timeout_t timeout);
void k_mbox_data_get(struct k_mbox_msg *rx_msg, void *buffer);
struct k_pipe {
			unsigned char *buffer;
			size_t size;
			size_t bytes_used;
			size_t read_index;
			size_t write_index;
			struct k_spinlock lock;
			struct {
			_wait_q_t readers;
			_wait_q_t writers;
			} wait_q;
			uint8_t flags;
};
void k_pipe_init(struct k_pipe *pipe, unsigned char *buffer, size_t size);
int k_pipe_cleanup(struct k_pipe *pipe);
static inline int k_pipe_alloc_init(struct k_pipe *pipe, size_t size);
static inline int k_pipe_put(struct k_pipe *pipe, const void *data,
			size_t bytes_to_write, size_t *bytes_written,
			size_t min_xfer, k_timeout_t timeout);
static inline int k_pipe_get(struct k_pipe *pipe, void *data,
			size_t bytes_to_read, size_t *bytes_read,
			size_t min_xfer, k_timeout_t timeout);
static inline size_t k_pipe_read_avail(struct k_pipe *pipe);
static inline size_t k_pipe_write_avail(struct k_pipe *pipe);
static inline void k_pipe_flush(struct k_pipe *pipe);
static inline void k_pipe_buffer_flush(struct k_pipe *pipe);
struct k_mem_slab_info {
			uint32_t num_blocks;
			size_t block_size;
			uint32_t num_used;
};
struct k_mem_slab {
			_wait_q_t wait_q;
			struct k_spinlock lock;
			char *buffer;
			char *free_list;
			struct k_mem_slab_info info;
};
int k_mem_slab_init(struct k_mem_slab *slab, void *buffer,
			size_t block_size, uint32_t num_blocks);
int k_mem_slab_alloc(struct k_mem_slab *slab, void **mem,
			k_timeout_t timeout);
void k_mem_slab_free(struct k_mem_slab *slab, void *mem);
static inline uint32_t k_mem_slab_num_used_get(struct k_mem_slab *slab)
{
			return slab->info.num_used;
}
static inline uint32_t k_mem_slab_max_used_get(struct k_mem_slab *slab)
{
			(void)(slab);
			return 0;
}
static inline uint32_t k_mem_slab_num_free_get(struct k_mem_slab *slab)
{
			return slab->info.num_blocks - slab->info.num_used;
}
int k_mem_slab_runtime_stats_get(struct k_mem_slab *slab, struct sys_memory=
_stats *stats);
int k_mem_slab_runtime_stats_reset_max(struct k_mem_slab *slab);
struct k_heap {
			struct sys_heap heap;
			_wait_q_t wait_q;
			struct k_spinlock lock;
};
void k_heap_init(struct k_heap *h, void *mem,
			size_t bytes) __attribute__((nonnull(1)));
void *k_heap_aligned_alloc(struct k_heap *h, size_t align, size_t bytes,
			k_timeout_t timeout) __attribute__((nonnull(1)));
void *k_heap_alloc(struct k_heap *h, size_t bytes,
			k_timeout_t timeout) __attribute__((nonnull(1)));
void k_heap_free(struct k_heap *h, void *mem) __attribute__((nonnull(1)));
void *k_aligned_alloc(size_t align, size_t size);
void *k_malloc(size_t size);
void k_free(void *ptr);
void *k_calloc(size_t nmemb, size_t size);
enum _poll_types_bits {
			_POLL_TYPE_IGNORE,
			_POLL_TYPE_SIGNAL,
			_POLL_TYPE_SEM_AVAILABLE,
			_POLL_TYPE_DATA_AVAILABLE,
			_POLL_TYPE_MSGQ_DATA_AVAILABLE,
			_POLL_TYPE_PIPE_DATA_AVAILABLE,
			_POLL_NUM_TYPES
};
enum _poll_states_bits {
			_POLL_STATE_NOT_READY,
			_POLL_STATE_SIGNALED,
			_POLL_STATE_SEM_AVAILABLE,
			_POLL_STATE_DATA_AVAILABLE,
			_POLL_STATE_CANCELLED,
			_POLL_STATE_MSGQ_DATA_AVAILABLE,
			_POLL_STATE_PIPE_DATA_AVAILABLE,
			_POLL_NUM_STATES
};
enum k_poll_modes {
			K_POLL_MODE_NOTIFY_ONLY =3D 0,
			K_POLL_NUM_MODES
};
struct k_poll_signal {
			sys_dlist_t poll_events;
			unsigned int signaled;
			int result;
};
struct k_poll_event {
			sys_dnode_t _node;
			struct z_poller *poller;
			uint32_t tag:8;
			uint32_t type:_POLL_NUM_TYPES;
			uint32_t state:_POLL_NUM_STATES;
			uint32_t mode:1;
			uint32_t unused:(32 - (0 + 8 + _POLL_NUM_TYPES + _POLL_NUM_STATES + 1 ))=
;
			union {
			void *obj;
			struct k_poll_signal *signal;
			struct k_sem *sem;
			struct k_fifo *fifo;
			struct k_queue *queue;
			struct k_msgq *msgq;
			};
};
void k_poll_event_init(struct k_poll_event *event, uint32_t type,
			int mode, void *obj);
static inline int k_poll(struct k_poll_event *events, int num_events,
			k_timeout_t timeout);
static inline void k_poll_signal_init(struct k_poll_signal *sig);
static inline void k_poll_signal_reset(struct k_poll_signal *sig);
static inline void k_poll_signal_check(struct k_poll_signal *sig,
			unsigned int *signaled, int *result);
static inline int k_poll_signal_raise(struct k_poll_signal *sig, int result=
);
static inline void k_cpu_idle(void)
{
			arch_cpu_idle();
}
static inline void k_cpu_atomic_idle(unsigned int key)
{
			arch_cpu_atomic_idle(key);
}
void z_init_static_threads(void);
void z_timer_expiration_handler(struct _timeout *t);
static inline void k_str_out(char *c, size_t n);
static inline int k_float_disable(struct k_thread *thread);
static inline int k_float_enable(struct k_thread *thread, unsigned int opti=
ons);
int k_thread_runtime_stats_get(k_tid_t thread,
			k_thread_runtime_stats_t *stats);
int k_thread_runtime_stats_all_get(k_thread_runtime_stats_t *stats);
int k_thread_runtime_stats_enable(k_tid_t thread);
int k_thread_runtime_stats_disable(k_tid_t thread);
void k_sys_runtime_stats_enable(void);
void k_sys_runtime_stats_disable(void);
void sys_trace_isr_enter(void);
void sys_trace_isr_exit(void);
void sys_trace_isr_exit_to_scheduler(void);
void sys_trace_idle(void);
extern k_thread_stack_t * z_impl_k_thread_stack_alloc(size_t size, int flag=
s);
static inline k_thread_stack_t * k_thread_stack_alloc(size_t size, int flag=
s)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_stack_alloc(size, flags);
}
extern int z_impl_k_thread_stack_free(k_thread_stack_t * stack);
static inline int k_thread_stack_free(k_thread_stack_t * stack)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_stack_free(stack);
}
extern k_tid_t z_impl_k_thread_create(struct k_thread * new_thread, k_threa=
d_stack_t * stack, size_t stack_size, k_thread_entry_t entry, void * p1, vo=
id * p2, void * p3, int prio, uint32_t options, k_timeout_t delay);
static inline k_tid_t k_thread_create(struct k_thread * new_thread, k_threa=
d_stack_t * stack, size_t stack_size, k_thread_entry_t entry, void * p1, vo=
id * p2, void * p3, int prio, uint32_t options, k_timeout_t delay)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_create(new_thread, stack, stack_size, entry, p1, =
p2, p3, prio, options, delay);
}
extern int z_impl_k_thread_stack_space_get(const struct k_thread * thread, =
size_t * unused_ptr);
static inline int k_thread_stack_space_get(const struct k_thread * thread, =
size_t * unused_ptr)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_stack_space_get(thread, unused_ptr);
}
extern int z_impl_k_thread_join(struct k_thread * thread, k_timeout_t timeo=
ut);
static inline int k_thread_join(struct k_thread * thread, k_timeout_t timeo=
ut)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_join(thread, timeout);
}
extern int32_t z_impl_k_sleep(k_timeout_t timeout);
static inline int32_t k_sleep(k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_sleep(timeout);
}
extern int32_t z_impl_k_usleep(int32_t us);
static inline int32_t k_usleep(int32_t us)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_usleep(us);
}
extern void z_impl_k_busy_wait(uint32_t usec_to_wait);
static inline void k_busy_wait(uint32_t usec_to_wait)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_busy_wait(usec_to_wait);
}
extern void z_impl_k_yield(void);
static inline void k_yield(void)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_yield();
}
extern void z_impl_k_wakeup(k_tid_t thread);
static inline void k_wakeup(k_tid_t thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_wakeup(thread);
}
extern k_tid_t z_impl_k_sched_current_thread_query(void);
static inline k_tid_t k_sched_current_thread_query(void)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_sched_current_thread_query();
}
extern void z_impl_k_thread_abort(k_tid_t thread);
static inline void k_thread_abort(k_tid_t thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_thread_abort(thread);
}
extern void z_impl_k_thread_start(k_tid_t thread);
static inline void k_thread_start(k_tid_t thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_thread_start(thread);
}
extern k_ticks_t z_impl_k_thread_timeout_expires_ticks(const struct k_threa=
d * t);
static inline k_ticks_t k_thread_timeout_expires_ticks(const struct k_threa=
d * t)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_timeout_expires_ticks(t);
}
extern k_ticks_t z_impl_k_thread_timeout_remaining_ticks(const struct k_thr=
ead * t);
static inline k_ticks_t k_thread_timeout_remaining_ticks(const struct k_thr=
ead * t)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_timeout_remaining_ticks(t);
}
extern int z_impl_k_thread_priority_get(k_tid_t thread);
static inline int k_thread_priority_get(k_tid_t thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_priority_get(thread);
}
extern void z_impl_k_thread_priority_set(k_tid_t thread, int prio);
static inline void k_thread_priority_set(k_tid_t thread, int prio)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_thread_priority_set(thread, prio);
}
extern void z_impl_k_thread_deadline_set(k_tid_t thread, int deadline);
static inline void k_thread_deadline_set(k_tid_t thread, int deadline)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_thread_deadline_set(thread, deadline);
}
extern void z_impl_k_thread_suspend(k_tid_t thread);
static inline void k_thread_suspend(k_tid_t thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_thread_suspend(thread);
}
extern void z_impl_k_thread_resume(k_tid_t thread);
static inline void k_thread_resume(k_tid_t thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_thread_resume(thread);
}
extern int z_impl_k_is_preempt_thread(void);
static inline int k_is_preempt_thread(void)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_is_preempt_thread();
}
extern void z_impl_k_thread_custom_data_set(void * value);
static inline void k_thread_custom_data_set(void * value)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_thread_custom_data_set(value);
}
extern void * z_impl_k_thread_custom_data_get(void);
static inline void * k_thread_custom_data_get(void)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_custom_data_get();
}
extern int z_impl_k_thread_name_set(k_tid_t thread, const char * str);
static inline int k_thread_name_set(k_tid_t thread, const char * str)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_name_set(thread, str);
}
extern int z_impl_k_thread_name_copy(k_tid_t thread, char * buf, size_t siz=
e);
static inline int k_thread_name_copy(k_tid_t thread, char * buf, size_t siz=
e)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_thread_name_copy(thread, buf, size);
}
extern void z_impl_k_timer_start(struct k_timer * timer, k_timeout_t durati=
on, k_timeout_t period);
static inline void k_timer_start(struct k_timer * timer, k_timeout_t durati=
on, k_timeout_t period)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_timer_start(timer, duration, period);
}
extern void z_impl_k_timer_stop(struct k_timer * timer);
static inline void k_timer_stop(struct k_timer * timer)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_timer_stop(timer);
}
extern uint32_t z_impl_k_timer_status_get(struct k_timer * timer);
static inline uint32_t k_timer_status_get(struct k_timer * timer)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_timer_status_get(timer);
}
extern uint32_t z_impl_k_timer_status_sync(struct k_timer * timer);
static inline uint32_t k_timer_status_sync(struct k_timer * timer)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_timer_status_sync(timer);
}
extern k_ticks_t z_impl_k_timer_expires_ticks(const struct k_timer * timer)=
;
static inline k_ticks_t k_timer_expires_ticks(const struct k_timer * timer)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_timer_expires_ticks(timer);
}
extern k_ticks_t z_impl_k_timer_remaining_ticks(const struct k_timer * time=
r);
static inline k_ticks_t k_timer_remaining_ticks(const struct k_timer * time=
r)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_timer_remaining_ticks(timer);
}
extern void z_impl_k_timer_user_data_set(struct k_timer * timer, void * use=
r_data);
static inline void k_timer_user_data_set(struct k_timer * timer, void * use=
r_data)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_timer_user_data_set(timer, user_data);
}
extern void * z_impl_k_timer_user_data_get(const struct k_timer * timer);
static inline void * k_timer_user_data_get(const struct k_timer * timer)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_timer_user_data_get(timer);
}
extern int64_t z_impl_k_uptime_ticks(void);
static inline int64_t k_uptime_ticks(void)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_uptime_ticks();
}
extern void z_impl_k_queue_init(struct k_queue * queue);
static inline void k_queue_init(struct k_queue * queue)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_queue_init(queue);
}
extern void z_impl_k_queue_cancel_wait(struct k_queue * queue);
static inline void k_queue_cancel_wait(struct k_queue * queue)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_queue_cancel_wait(queue);
}
extern int32_t z_impl_k_queue_alloc_append(struct k_queue * queue, void * d=
ata);
static inline int32_t k_queue_alloc_append(struct k_queue * queue, void * d=
ata)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_queue_alloc_append(queue, data);
}
extern int32_t z_impl_k_queue_alloc_prepend(struct k_queue * queue, void * =
data);
static inline int32_t k_queue_alloc_prepend(struct k_queue * queue, void * =
data)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_queue_alloc_prepend(queue, data);
}
extern void * z_impl_k_queue_get(struct k_queue * queue, k_timeout_t timeou=
t);
static inline void * k_queue_get(struct k_queue * queue, k_timeout_t timeou=
t)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_queue_get(queue, timeout);
}
extern int z_impl_k_queue_is_empty(struct k_queue * queue);
static inline int k_queue_is_empty(struct k_queue * queue)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_queue_is_empty(queue);
}
extern void * z_impl_k_queue_peek_head(struct k_queue * queue);
static inline void * k_queue_peek_head(struct k_queue * queue)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_queue_peek_head(queue);
}
extern void * z_impl_k_queue_peek_tail(struct k_queue * queue);
static inline void * k_queue_peek_tail(struct k_queue * queue)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_queue_peek_tail(queue);
}
extern int z_impl_k_futex_wait(struct k_futex * futex, int expected, k_time=
out_t timeout);
static inline int k_futex_wait(struct k_futex * futex, int expected, k_time=
out_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_futex_wait(futex, expected, timeout);
}
extern int z_impl_k_futex_wake(struct k_futex * futex, _Bool wake_all);
static inline int k_futex_wake(struct k_futex * futex, _Bool wake_all)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_futex_wake(futex, wake_all);
}
extern void z_impl_k_event_init(struct k_event * event);
static inline void k_event_init(struct k_event * event)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_event_init(event);
}
extern uint32_t z_impl_k_event_post(struct k_event * event, uint32_t events=
);
static inline uint32_t k_event_post(struct k_event * event, uint32_t events=
)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_event_post(event, events);
}
extern uint32_t z_impl_k_event_set(struct k_event * event, uint32_t events)=
;
static inline uint32_t k_event_set(struct k_event * event, uint32_t events)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_event_set(event, events);
}
extern uint32_t z_impl_k_event_set_masked(struct k_event * event, uint32_t =
events, uint32_t events_mask);
static inline uint32_t k_event_set_masked(struct k_event * event, uint32_t =
events, uint32_t events_mask)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_event_set_masked(event, events, events_mask);
}
extern uint32_t z_impl_k_event_clear(struct k_event * event, uint32_t event=
s);
static inline uint32_t k_event_clear(struct k_event * event, uint32_t event=
s)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_event_clear(event, events);
}
extern uint32_t z_impl_k_event_wait(struct k_event * event, uint32_t events=
, _Bool reset, k_timeout_t timeout);
static inline uint32_t k_event_wait(struct k_event * event, uint32_t events=
, _Bool reset, k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_event_wait(event, events, reset, timeout);
}
extern uint32_t z_impl_k_event_wait_all(struct k_event * event, uint32_t ev=
ents, _Bool reset, k_timeout_t timeout);
static inline uint32_t k_event_wait_all(struct k_event * event, uint32_t ev=
ents, _Bool reset, k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_event_wait_all(event, events, reset, timeout);
}
extern int32_t z_impl_k_stack_alloc_init(struct k_stack * stack, uint32_t n=
um_entries);
static inline int32_t k_stack_alloc_init(struct k_stack * stack, uint32_t n=
um_entries)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_stack_alloc_init(stack, num_entries);
}
extern int z_impl_k_stack_push(struct k_stack * stack, stack_data_t data);
static inline int k_stack_push(struct k_stack * stack, stack_data_t data)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_stack_push(stack, data);
}
extern int z_impl_k_stack_pop(struct k_stack * stack, stack_data_t * data, =
k_timeout_t timeout);
static inline int k_stack_pop(struct k_stack * stack, stack_data_t * data, =
k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_stack_pop(stack, data, timeout);
}
extern int z_impl_k_mutex_init(struct k_mutex * mutex);
static inline int k_mutex_init(struct k_mutex * mutex)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_mutex_init(mutex);
}
extern int z_impl_k_mutex_lock(struct k_mutex * mutex, k_timeout_t timeout)=
;
static inline int k_mutex_lock(struct k_mutex * mutex, k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_mutex_lock(mutex, timeout);
}
extern int z_impl_k_mutex_unlock(struct k_mutex * mutex);
static inline int k_mutex_unlock(struct k_mutex * mutex)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_mutex_unlock(mutex);
}
extern int z_impl_k_condvar_init(struct k_condvar * condvar);
static inline int k_condvar_init(struct k_condvar * condvar)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_condvar_init(condvar);
}
extern int z_impl_k_condvar_signal(struct k_condvar * condvar);
static inline int k_condvar_signal(struct k_condvar * condvar)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_condvar_signal(condvar);
}
extern int z_impl_k_condvar_broadcast(struct k_condvar * condvar);
static inline int k_condvar_broadcast(struct k_condvar * condvar)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_condvar_broadcast(condvar);
}
extern int z_impl_k_condvar_wait(struct k_condvar * condvar, struct k_mutex=
 * mutex, k_timeout_t timeout);
static inline int k_condvar_wait(struct k_condvar * condvar, struct k_mutex=
 * mutex, k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_condvar_wait(condvar, mutex, timeout);
}
extern int z_impl_k_sem_init(struct k_sem * sem, unsigned int initial_count=
, unsigned int limit);
static inline int k_sem_init(struct k_sem * sem, unsigned int initial_count=
, unsigned int limit)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_sem_init(sem, initial_count, limit);
}
extern int z_impl_k_sem_take(struct k_sem * sem, k_timeout_t timeout);
static inline int k_sem_take(struct k_sem * sem, k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_sem_take(sem, timeout);
}
extern void z_impl_k_sem_give(struct k_sem * sem);
static inline void k_sem_give(struct k_sem * sem)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_sem_give(sem);
}
extern void z_impl_k_sem_reset(struct k_sem * sem);
static inline void k_sem_reset(struct k_sem * sem)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_sem_reset(sem);
}
extern unsigned int z_impl_k_sem_count_get(struct k_sem * sem);
static inline unsigned int k_sem_count_get(struct k_sem * sem)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_sem_count_get(sem);
}
extern int z_impl_k_msgq_alloc_init(struct k_msgq * msgq, size_t msg_size, =
uint32_t max_msgs);
static inline int k_msgq_alloc_init(struct k_msgq * msgq, size_t msg_size, =
uint32_t max_msgs)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_msgq_alloc_init(msgq, msg_size, max_msgs);
}
extern int z_impl_k_msgq_put(struct k_msgq * msgq, const void * data, k_tim=
eout_t timeout);
static inline int k_msgq_put(struct k_msgq * msgq, const void * data, k_tim=
eout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_msgq_put(msgq, data, timeout);
}
extern int z_impl_k_msgq_get(struct k_msgq * msgq, void * data, k_timeout_t=
 timeout);
static inline int k_msgq_get(struct k_msgq * msgq, void * data, k_timeout_t=
 timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_msgq_get(msgq, data, timeout);
}
extern int z_impl_k_msgq_peek(struct k_msgq * msgq, void * data);
static inline int k_msgq_peek(struct k_msgq * msgq, void * data)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_msgq_peek(msgq, data);
}
extern int z_impl_k_msgq_peek_at(struct k_msgq * msgq, void * data, uint32_=
t idx);
static inline int k_msgq_peek_at(struct k_msgq * msgq, void * data, uint32_=
t idx)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_msgq_peek_at(msgq, data, idx);
}
extern void z_impl_k_msgq_purge(struct k_msgq * msgq);
static inline void k_msgq_purge(struct k_msgq * msgq)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_msgq_purge(msgq);
}
extern uint32_t z_impl_k_msgq_num_free_get(struct k_msgq * msgq);
static inline uint32_t k_msgq_num_free_get(struct k_msgq * msgq)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_msgq_num_free_get(msgq);
}
extern void z_impl_k_msgq_get_attrs(struct k_msgq * msgq, struct k_msgq_att=
rs * attrs);
static inline void k_msgq_get_attrs(struct k_msgq * msgq, struct k_msgq_att=
rs * attrs)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_msgq_get_attrs(msgq, attrs);
}
extern uint32_t z_impl_k_msgq_num_used_get(struct k_msgq * msgq);
static inline uint32_t k_msgq_num_used_get(struct k_msgq * msgq)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_msgq_num_used_get(msgq);
}
extern int z_impl_k_pipe_alloc_init(struct k_pipe * pipe, size_t size);
static inline int k_pipe_alloc_init(struct k_pipe * pipe, size_t size)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_pipe_alloc_init(pipe, size);
}
extern int z_impl_k_pipe_put(struct k_pipe * pipe, const void * data, size_=
t bytes_to_write, size_t * bytes_written, size_t min_xfer, k_timeout_t time=
out);
static inline int k_pipe_put(struct k_pipe * pipe, const void * data, size_=
t bytes_to_write, size_t * bytes_written, size_t min_xfer, k_timeout_t time=
out)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_pipe_put(pipe, data, bytes_to_write, bytes_written, min_=
xfer, timeout);
}
extern int z_impl_k_pipe_get(struct k_pipe * pipe, void * data, size_t byte=
s_to_read, size_t * bytes_read, size_t min_xfer, k_timeout_t timeout);
static inline int k_pipe_get(struct k_pipe * pipe, void * data, size_t byte=
s_to_read, size_t * bytes_read, size_t min_xfer, k_timeout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_pipe_get(pipe, data, bytes_to_read, bytes_read, min_xfer=
, timeout);
}
extern size_t z_impl_k_pipe_read_avail(struct k_pipe * pipe);
static inline size_t k_pipe_read_avail(struct k_pipe * pipe)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_pipe_read_avail(pipe);
}
extern size_t z_impl_k_pipe_write_avail(struct k_pipe * pipe);
static inline size_t k_pipe_write_avail(struct k_pipe * pipe)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_pipe_write_avail(pipe);
}
extern void z_impl_k_pipe_flush(struct k_pipe * pipe);
static inline void k_pipe_flush(struct k_pipe * pipe)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_pipe_flush(pipe);
}
extern void z_impl_k_pipe_buffer_flush(struct k_pipe * pipe);
static inline void k_pipe_buffer_flush(struct k_pipe * pipe)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_pipe_buffer_flush(pipe);
}
extern int z_impl_k_poll(struct k_poll_event * events, int num_events, k_ti=
meout_t timeout);
static inline int k_poll(struct k_poll_event * events, int num_events, k_ti=
meout_t timeout)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_poll(events, num_events, timeout);
}
extern void z_impl_k_poll_signal_init(struct k_poll_signal * sig);
static inline void k_poll_signal_init(struct k_poll_signal * sig)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_poll_signal_init(sig);
}
extern void z_impl_k_poll_signal_reset(struct k_poll_signal * sig);
static inline void k_poll_signal_reset(struct k_poll_signal * sig)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_poll_signal_reset(sig);
}
extern void z_impl_k_poll_signal_check(struct k_poll_signal * sig, unsigned=
 int * signaled, int * result);
static inline void k_poll_signal_check(struct k_poll_signal * sig, unsigned=
 int * signaled, int * result)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_poll_signal_check(sig, signaled, result);
}
extern int z_impl_k_poll_signal_raise(struct k_poll_signal * sig, int resul=
t);
static inline int k_poll_signal_raise(struct k_poll_signal * sig, int resul=
t)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_poll_signal_raise(sig, result);
}
extern void z_impl_k_str_out(char * c, size_t n);
static inline void k_str_out(char * c, size_t n)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			z_impl_k_str_out(c, n);
}
extern int z_impl_k_float_disable(struct k_thread * thread);
static inline int k_float_disable(struct k_thread * thread)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_float_disable(thread);
}
extern int z_impl_k_float_enable(struct k_thread * thread, unsigned int opt=
ions);
static inline int k_float_enable(struct k_thread * thread, unsigned int opt=
ions)
{
			do { __asm__ __volatile__ ("" ::: "memory"); } while (0);
			return z_impl_k_float_enable(thread, options);
}
void arch_busy_wait(uint32_t usec_to_wait);
void arch_new_thread(struct k_thread *thread, k_thread_stack_t *stack,
			char *stack_ptr, k_thread_entry_t entry,
			void *p1, void *p2, void *p3);
static inline void arch_switch(void *switch_to, void **switched_from);
int arch_float_disable(struct k_thread *thread);
int arch_float_enable(struct k_thread *thread, unsigned int options);
__attribute__((__noreturn__)) void arch_system_halt(unsigned int reason);
static inline _Bool arch_is_in_isr(void);
void arch_mem_map(void *virt, uintptr_t phys, size_t size, uint32_t flags);
void arch_mem_unmap(void *addr, size_t size);
int arch_page_phys_get(void *virt, uintptr_t *phys);
void arch_reserved_pages_update(void);
void arch_mem_page_out(void *addr, uintptr_t location);
void arch_mem_page_in(void *addr, uintptr_t phys);
void arch_mem_scratch(uintptr_t phys);
enum arch_page_location {
			ARCH_PAGE_LOCATION_PAGED_OUT,
			ARCH_PAGE_LOCATION_PAGED_IN,
			ARCH_PAGE_LOCATION_BAD
};
enum arch_page_location arch_page_location_get(void *addr, uintptr_t *locat=
ion);
uintptr_t arch_page_info_get(void *addr, uintptr_t *location,
			_Bool clear_accessed);
int arch_printk_char_out(int c);
static inline void arch_kernel_init(void);
static inline void arch_nop(void);
void arch_coredump_info_dump(const z_arch_esf_t *esf);
uint16_t arch_coredump_tgt_code_get(void);
size_t arch_tls_stack_setup(struct k_thread *new_thread, char *stack_ptr);
static inline __attribute__((always_inline)) _Bool arch_is_in_isr(void)
{
			return arch_curr_cpu()->nested !=3D 0U;
}
typedef struct __esf _esf_t;
typedef struct __basic_sf _basic_sf_t;
static inline __attribute__((always_inline)) void arch_kernel_init(void)
{
}
static inline void arch_switch(void *switch_to, void **switched_from)
{
			extern void z_arm64_context_switch(struct k_thread *new,
			struct k_thread *old);
			struct k_thread *new =3D switch_to;
			struct k_thread *old =3D ({ extern int (*__Static_assert_function (void)=
) [!!sizeof (struct { int __error_if_negative: (__builtin_types_compatible_=
p(__typeof__(*(switched_from)), __typeof__(((struct k_thread *)0)->switch_h=
andle)) || __builtin_types_compatible_p(__typeof__(*(switched_from)), __typ=
eof__(void))) ? 2 : -1; })]; ((struct k_thread *)(((char *)(switched_from))=
 - __builtin_offsetof (struct k_thread, switch_handle))); });
			z_arm64_context_switch(new, old);
}
extern void z_arm64_fatal_error(unsigned int reason, z_arch_esf_t *esf);
extern void z_arm64_set_ttbr0(uint64_t ttbr0);
extern void z_arm64_mem_cfg_ipi(void);
void z_arm64_flush_local_fpu(void);
void z_arm64_flush_fpu_ipi(unsigned int cpu);
extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
			size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__n=
onnull__ (1, 2)));
extern void *memmove (void *__dest, const void *__src, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern void *memset (void *__s, int __c, size_t __n) __attribute__ ((__noth=
row__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern int memcmp (const void *__s1, const void *__s2, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern int __memcmpeq (const void *__s1, const void *__s2, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern void *memchr (const void *__s, int __c, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1)));
extern char *strcpy (char *__restrict __dest, const char *__restrict __src)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern char *strncpy (char *__restrict __dest,
			const char *__restrict __src, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern char *strcat (char *__restrict __dest, const char *__restrict __src)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern char *strncat (char *__restrict __dest, const char *__restrict __src=
,
			size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__n=
onnull__ (1, 2)));
extern int strcmp (const char *__s1, const char *__s2)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern int strncmp (const char *__s1, const char *__s2, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern int strcoll (const char *__s1, const char *__s2)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern size_t strxfrm (char *__restrict __dest,
			const char *__restrict __src, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)=
)) __attribute__ ((__access__ (__write_only__, 1, 3)));
struct __locale_struct
{
		struct __locale_data *__locales[13];
		const unsigned short int *__ctype_b;
		const int *__ctype_tolower;
		const int *__ctype_toupper;
		const char *__names[13];
};
typedef struct __locale_struct *__locale_t;
typedef __locale_t locale_t;
extern int strcoll_l (const char *__s1, const char *__s2, locale_t __l)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2, 3)));
extern size_t strxfrm_l (char *__dest, const char *__src, size_t __n,
			locale_t __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((_=
_nonnull__ (2, 4)))
			__attribute__ ((__access__ (__write_only__, 1, 3)));
extern char *strdup (const char *__s)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __=
attribute__ ((__nonnull__ (1)));
extern char *strndup (const char *__string, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __=
attribute__ ((__nonnull__ (1)));
extern char *strchr (const char *__s, int __c)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1)));
extern char *strrchr (const char *__s, int __c)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1)));
extern size_t strcspn (const char *__s, const char *__reject)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern size_t strspn (const char *__s, const char *__accept)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern char *strpbrk (const char *__s, const char *__accept)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern char *strstr (const char *__haystack, const char *__needle)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1, 2)));
extern char *strtok (char *__restrict __s, const char *__restrict __delim)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)=
));
extern char *__strtok_r (char *__restrict __s,
			const char *__restrict __delim,
			char **__restrict __save_ptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2,=
 3)));
extern char *strtok_r (char *__restrict __s, const char *__restrict __delim=
,
			char **__restrict __save_ptr)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2,=
 3)));
extern size_t strlen (const char *__s)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1)));
extern size_t strnlen (const char *__string, size_t __maxlen)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __at=
tribute__ ((__nonnull__ (1)));
extern char *strerror (int __errnum) __attribute__ ((__nothrow__ , __leaf__=
));
extern int strerror_r (int __errnum, char *__buf, size_t __buflen) __asm__ =
("__USER_LABEL_PREFIX__" "__xpg_strerror_r") __attribute__ ((__nothrow__ , =
__leaf__)) __attribute__ ((__nonnull__ (2)))
			__attribute__ ((__access__ (__write_only__, 2, 3)));
extern char *strerror_l (int __errnum, locale_t __l) __attribute__ ((__noth=
row__ , __leaf__));
extern char *strsignal (int __sig) __attribute__ ((__nothrow__ , __leaf__))=
;
extern char *__stpcpy (char *__restrict __dest, const char *__restrict __sr=
c)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern char *stpcpy (char *__restrict __dest, const char *__restrict __src)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern char *__stpncpy (char *__restrict __dest,
			const char *__restrict __src, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern char *stpncpy (char *__restrict __dest,
			const char *__restrict __src, size_t __n)
			__attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1,=
 2)));
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) void *
__attribute__ ((__nothrow__ , __leaf__)) memcpy (void *__restrict __dest, c=
onst void *__restrict __src, size_t __len)
{
		return __builtin___memcpy_chk (__dest, __src, __len,
			__builtin_object_size (__dest, 0));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) void *
__attribute__ ((__nothrow__ , __leaf__)) memmove (void *__dest, const void =
*__src, size_t __len)
{
		return __builtin___memmove_chk (__dest, __src, __len,
			__builtin_object_size (__dest, 0));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) void *
__attribute__ ((__nothrow__ , __leaf__)) memset (void *__dest, int __ch, si=
ze_t __len)
{
		return __builtin___memset_chk (__dest, __ch, __len,
			__builtin_object_size (__dest, 0));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) char *
__attribute__ ((__nothrow__ , __leaf__)) strcpy (char *__restrict __dest, c=
onst char *__restrict __src)
{
		return __builtin___strcpy_chk (__dest, __src, __builtin_object_size (__de=
st, 1 > 1));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) char *
__attribute__ ((__nothrow__ , __leaf__)) stpcpy (char *__restrict __dest, c=
onst char *__restrict __src)
{
		return __builtin___stpcpy_chk (__dest, __src, __builtin_object_size (__de=
st, 1 > 1));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) char *
__attribute__ ((__nothrow__ , __leaf__)) strncpy (char *__restrict __dest, =
const char *__restrict __src, size_t __len)
{
		return __builtin___strncpy_chk (__dest, __src, __len,
			__builtin_object_size (__dest, 1 > 1));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) char *
__attribute__ ((__nothrow__ , __leaf__)) stpncpy (char *__dest, const char =
*__src, size_t __n)
{
		return __builtin___stpncpy_chk (__dest, __src, __n,
			__builtin_object_size (__dest, 1 > 1));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) char *
__attribute__ ((__nothrow__ , __leaf__)) strcat (char *__restrict __dest, c=
onst char *__restrict __src)
{
		return __builtin___strcat_chk (__dest, __src, __builtin_object_size (__de=
st, 1 > 1));
}
extern __inline __attribute__ ((__always_inline__)) __attribute__ ((__artif=
icial__)) char *
__attribute__ ((__nothrow__ , __leaf__)) strncat (char *__restrict __dest, =
const char *__restrict __src, size_t __len)
{
		return __builtin___strncat_chk (__dest, __src, __len,
			__builtin_object_size (__dest, 1 > 1));
}
void z_init_thread_base(struct _thread_base *thread_base, int priority,
			uint32_t initial_state, unsigned int options);
void z_early_memset(void *dst, int c, size_t n);
void z_early_memcpy(void *dst, const void *src, size_t n);
void z_bss_zero(void);
static inline void z_data_copy(void)
{
}
static inline void z_bss_zero_boot(void)
{
}
static inline void z_bss_zero_pinned(void)
{
}
__attribute__((__noreturn__)) void z_cstart(void);
void z_device_state_init(void);
extern __attribute__((__noreturn__)) void z_thread_entry(k_thread_entry_t e=
ntry,
			void *p1, void *p2, void *p3);
extern char *z_setup_new_thread(struct k_thread *new_thread,
			k_thread_stack_t *stack, size_t stack_size,
			k_thread_entry_t entry,
			void *p1, void *p2, void *p3,
			int prio, uint32_t options, const char *name);
void *z_thread_aligned_alloc(size_t align, size_t size);
static inline void *z_thread_malloc(size_t size)
{
			return z_thread_aligned_alloc(0, size);
}
extern void z_thread_essential_set(void);
extern void z_thread_essential_clear(void);
static inline __attribute__((always_inline)) void
arch_thread_return_value_set(struct k_thread *thread, unsigned int value)
{
			thread->swap_retval =3D value;
}
static inline __attribute__((always_inline)) void
z_thread_return_value_set_with_data(struct k_thread *thread,
			unsigned int value,
			void *data)
{
			arch_thread_return_value_set(thread, value);
			thread->base.swap_data =3D data;
}
extern void z_early_rand_get(uint8_t *buf, size_t length);
extern struct k_thread z_main_thread;
extern struct k_thread z_idle_threads[1];
extern struct z_thread_stack_element z_interrupt_stacks[1][((((unsigned lon=
g)((((((unsigned long)(4096) + ((unsigned long)(16) - 1)) / (unsigned long)=
(16)) * (unsigned long)(16)) + ((size_t)0))) + ((unsigned long)(16) - 1)) /=
 (unsigned long)(16)) * (unsigned long)(16))];
int z_stack_space_get(const uint8_t *stack_start, size_t size, size_t *unus=
ed_ptr);
void z_mem_manage_init(void);
void z_mem_manage_boot_finish(void);
void z_handle_obj_poll_events(sys_dlist_t *events, uint32_t state);
extern char _app_smem_start[];
extern char _app_smem_end[];
extern char _app_smem_size[];
extern char _app_smem_rom_start[];
extern char _app_smem_num_words[];
extern char __kernel_ram_start[];
extern char __kernel_ram_end[];
extern char __kernel_ram_size[];
extern char __bss_start[];
extern char __bss_end[];
extern char z_mapped_start[];
extern char z_mapped_end[];
extern char __rom_region_start[];
extern char __rom_region_end[];
extern char __rom_region_size[];
extern char _flash_used[];
extern char _image_ram_start[];
extern char _image_ram_end[];
extern char _image_ram_size[];
extern char __text_region_start[];
extern char __text_region_end[];
extern char __text_region_size[];
extern char __rodata_region_start[];
extern char __rodata_region_end[];
extern char __rodata_region_size[];
extern char _vector_start[];
extern char _vector_end[];
extern char _end[];
extern char __tdata_start[];
extern char __tdata_end[];
extern char __tdata_size[];
extern char __tdata_align[];
extern char __tbss_start[];
extern char __tbss_end[];
extern char __tbss_size[];
extern char __tbss_align[];
extern char __tls_start[];
extern char __tls_end[];
extern char __tls_size[];
static inline size_t z_tls_data_size(void)
{
			size_t tdata_size =3D ((((unsigned long)(__tdata_size) + ((unsigned long=
)(__tdata_align) - 1)) / (unsigned long)(__tdata_align)) * (unsigned long)(=
__tdata_align));
			size_t tbss_size =3D ((((unsigned long)(__tbss_size) + ((unsigned long)(=
__tbss_align) - 1)) / (unsigned long)(__tbss_align)) * (unsigned long)(__tb=
ss_align));
			return tdata_size + tbss_size;
}
static inline void z_tls_copy(char *dest)
{
			size_t tdata_size =3D (size_t)__tdata_size;
			size_t tbss_size =3D (size_t)__tbss_size;
			memcpy(dest, __tdata_start, tdata_size);
			dest +=3D ((((unsigned long)(tdata_size) + ((unsigned long)(__tdata_alig=
n) - 1)) / (unsigned long)(__tdata_align)) * (unsigned long)(__tdata_align)=
);
			memset(dest, 0, tbss_size);
}
size_t arch_tls_stack_setup(struct k_thread *new_thread, char *stack_ptr)
{
			stack_ptr -=3D z_tls_data_size();
			z_tls_copy(stack_ptr);
			stack_ptr -=3D sizeof(uintptr_t) * 2;
			new_thread->tls =3D ((uintptr_t) (stack_ptr));
			return (z_tls_data_size() + (sizeof(uintptr_t) * 2));
}

