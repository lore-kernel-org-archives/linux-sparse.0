Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC7C433E0
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E7A20449
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbhAERzo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 5 Jan 2021 12:55:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:50809 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbhAERzo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 5 Jan 2021 12:55:44 -0500
IronPort-SDR: sOcDix0sbhPctsy8BScTgbHu/Q6oa9eZ8+rDneVIhc6A36HVv308lUH0Do75k7pR/zDtu2n2yF
 3+L4T1vQQE7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="241234030"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="241234030"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 09:55:02 -0800
IronPort-SDR: 9yzvNCKk1dtFJeGGKdMfvMdZSOWt3C40a4xGdcx98nvcDJevqlR6uyPKqMIuKs+IYgydHzl+dM
 yyT/AO4QBVEw==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="349944639"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.212.7.147]) ([10.212.7.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 09:55:02 -0800
Subject: Re: [PATCH 00/16] support __packed struct
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <404858f7-a7cc-108a-73d0-bd52cda11a42@intel.com>
Date:   Tue, 5 Jan 2021 09:55:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 12/26/2020 9:51 AM, Luc Van Oostenryck wrote:
> During parsing, Sparse recognizes the attribute 'packed' but this
> attribute is otherwise ignored for several reasons:
> 1) the attribute in 'struct __attr { ... }' is wrongly handled as
>    belonging to the whole declaration but it should belong to the type,
> 2) the attribute in 'struct <name> { ... } __attr;' is simply ignored,
> 3) the layout of packed bitfields need special care.
> 
> This series contains 2 parts:
> 1) handling of type attributes
> 2) correct layout of packed structs, including packed bitfields.
> 
> 
> This series is also available for review and testing at:
>   git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git packed-v2
> 

This series looks good to me, and it resolves the issues I saw a few
weeks ago with size.

Thanks,
Jake

> 
> Changes since v1:
> * fix layout of packed bitfields
> 
> Luc Van Oostenryck (16):
>   add testcases for dubious enum values
>   add testcases for exotic enum values
>   add testcases for enum attributes
>   add testcases for type attributes
>   add testcases for packed structures
>   add testcases for packed bitfields
>   apply_ctype: use self-explanatory argument name
>   apply_ctype: reverse the order of arguments
>   apply_ctype: move up its declaration
>   struct-attr: prepare to handle attributes at the end of struct definitions (1)
>   struct-attr: prepare to handle attributes at the end of struct definitions (2)
>   struct-attr: prepare to handle attributes at the end of struct definitions (3)
>   struct-attr: fix type attribute like 'struct __attr { ... }'
>   struct-attr: fix: do not ignore struct/union/enum type attributes
>   packed: no out-of-bound access of packed bitfields
>   packed: add support for __packed struct
> 
>  linearize.c                       | 13 +++++-
>  parse.c                           | 71 ++++++++++++++++---------------
>  symbol.c                          | 12 ++++--
>  symbol.h                          |  2 +
>  validation/enum-type-dubious.c    | 18 ++++++++
>  validation/enum-type-exotic.c     | 28 ++++++++++++
>  validation/packed-bitfield0.c     | 66 ++++++++++++++++++++++++++++
>  validation/packed-bitfield1.c     | 27 ++++++++++++
>  validation/packed-bitfield2.c     | 15 +++++++
>  validation/packed-bitfield3.c     | 28 ++++++++++++
>  validation/packed-bitfield4.c     | 18 ++++++++
>  validation/packed-bitfield5.c     | 20 +++++++++
>  validation/packed-deref0.c        | 23 ++++++++++
>  validation/packed-struct.c        | 32 ++++++++++++++
>  validation/parsing/enum-attr.c    | 29 +++++++++++++
>  validation/type-attribute-align.c | 19 +++++++++
>  validation/type-attribute-as.c    | 33 ++++++++++++++
>  validation/type-attribute-mod.c   | 21 +++++++++
>  validation/type-attribute-qual.c  | 12 ++++++
>  19 files changed, 448 insertions(+), 39 deletions(-)
>  create mode 100644 validation/enum-type-dubious.c
>  create mode 100644 validation/enum-type-exotic.c
>  create mode 100644 validation/packed-bitfield0.c
>  create mode 100644 validation/packed-bitfield1.c
>  create mode 100644 validation/packed-bitfield2.c
>  create mode 100644 validation/packed-bitfield3.c
>  create mode 100644 validation/packed-bitfield4.c
>  create mode 100644 validation/packed-bitfield5.c
>  create mode 100644 validation/packed-deref0.c
>  create mode 100644 validation/packed-struct.c
>  create mode 100644 validation/parsing/enum-attr.c
>  create mode 100644 validation/type-attribute-align.c
>  create mode 100644 validation/type-attribute-as.c
>  create mode 100644 validation/type-attribute-mod.c
>  create mode 100644 validation/type-attribute-qual.c
> 
> 
> base-commit: 1b896707d95982c7c9cdd5cd0ab4afd80f766a94
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> 
