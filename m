Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E9C433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 15:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2464620798
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 15:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgLaPbO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 10:31:14 -0500
Received: from avasout06.plus.net ([212.159.14.18]:36708 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLaPbN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 10:31:13 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id uzuCkTIMYhO4HuzuEkE0Ml; Thu, 31 Dec 2020 15:30:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609428626; bh=CMmiQamKFcmhTIa8L2TLFMM8YOllGLeVU+7i3/juNzU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ebPdT8N6F7UUJtwMXf5vE7DdVUuu0i05a0fk842DjK3oRHshzvOVdjosDoyn9BLfd
         1t2jWCVWzA2SrnWfBdg0iW00Gt0Dps9kmF4YGh8y/caf4lO1g8SFAFjZAzc+Lxczq/
         UH5HQWG9Qxo3emTdSq/x75/rEFJs/yhuI7FGgTMIw2NDoPlP1TNltSxT2GjJ/j3voh
         sWrIdWsnJX62kwwcEPYOdH756d3GzRPIMSM+fpxvFFWDQBNfIKMFU+lJ3aAerCVV8r
         wxio4I5EkVMA3L/HTVCE8fyXNqmVkTlatKMx86rGqK/CG99cWjCM33gbJeMOQcDPK3
         JObliHvs8ha5g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=JrmIlNXS2SXWZTdwscoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 00/16] support __packed struct
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5c9945a4-f9bc-68a9-31f0-ae0958d06f84@ramsayjones.plus.com>
Date:   Thu, 31 Dec 2020 15:30:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKhpd7R+03+zCWXaR+sJZa9m9Gef/4QfAF63m2MZ7cfceLzAWSzPiFmL+kga9s4oj0rKuqRrkD7E6T7zJxPoRJH2z+9385NXghmUa9Yp06sCR9Acf+2l
 +OaE7C84ajSqWZiJOxitfVBmvmDtnkPr5KRHfB8F9SpTUnJUeEu6ocItiW3cYHkkILVC/5ycEluhOg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 31/12/2020 10:10, Luc Van Oostenryck wrote:
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
>   git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git packed-v3
> 
> 
> Changes since v2 (all thanks to Ramsay Jones):
> * correct several typos
> * add an explanation for one of the test
> * avoid sizeof() in tests where the size is constrained to some fixed value
> * remove a redundency in a test (struct sb identical to struct sa)
> * reformulate the commit message for apply_ctype()'s arguments reversal
> * tweak the not-so-1-to-1 code movement
> * fix the truncated commit message of the last patch

This all LGTM. Thanks!

ATB,
Ramsay Jones

> 
> Changes since v1:
> * fix layout of packed bitfields
> 
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
>   struct-attr: prepare to handle attributes at the end of struct
>     definitions (1)
>   struct-attr: prepare to handle attributes at the end of struct
>     definitions (2)
>   struct-attr: prepare to handle attributes at the end of struct
>     definitions (3)
>   struct-attr: fix type attribute like 'struct __attr { ... }'
>   struct-attr: fix: do not ignore struct/union/enum type attributes
>   packed: no out-of-bound access of packed bitfields
>   packed: add support for __packed struct
> 
>  Documentation/TODO.md             |  3 --
>  linearize.c                       | 13 +++++-
>  parse.c                           | 78 ++++++++++++++++---------------
>  symbol.c                          | 12 +++--
>  symbol.h                          |  2 +
>  validation/enum-type-dubious.c    | 18 +++++++
>  validation/enum-type-exotic.c     | 28 +++++++++++
>  validation/packed-bitfield0.c     | 58 +++++++++++++++++++++++
>  validation/packed-bitfield1.c     | 27 +++++++++++
>  validation/packed-bitfield2.c     | 15 ++++++
>  validation/packed-bitfield3.c     | 28 +++++++++++
>  validation/packed-bitfield4.c     | 18 +++++++
>  validation/packed-bitfield5.c     | 20 ++++++++
>  validation/packed-deref0.c        | 23 +++++++++
>  validation/packed-struct.c        | 32 +++++++++++++
>  validation/parsing/enum-attr.c    | 29 ++++++++++++
>  validation/type-attribute-align.c | 19 ++++++++
>  validation/type-attribute-as.c    | 33 +++++++++++++
>  validation/type-attribute-mod.c   | 21 +++++++++
>  validation/type-attribute-qual.c  | 15 ++++++
>  20 files changed, 447 insertions(+), 45 deletions(-)
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
