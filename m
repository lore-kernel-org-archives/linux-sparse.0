Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D2C433DB
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342D920449
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 17:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbhAER4q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 5 Jan 2021 12:56:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:45409 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730612AbhAER4q (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 5 Jan 2021 12:56:46 -0500
IronPort-SDR: +mc4ZhWm76YT6bWqkVmc5UG/AiiXhinNpOSeOYqiYQEPz3OlRu7cVG8fZpi2vJCV94fjvXBd4i
 +OavZcfv8yNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="176370872"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="176370872"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 09:56:06 -0800
IronPort-SDR: vvCUF3ZPkbvgwyJbHBbVt6NmyIzLOG812AlzpcAmd3/fUs0q7DQuKfiJ/2K5VSFMq6H9cLjC+I
 vD5QDN9uV/zQ==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="349944838"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.212.7.147]) ([10.212.7.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 09:56:05 -0800
Subject: Re: [PATCH 00/16] support __packed struct
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <6a00eea2-7371-de84-05fc-1375603ed7eb@ramsayjones.plus.com>
 <20201228213338.e5tspbe3od27lo4x@ltop.local>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <49f5ad45-5776-ab70-53c9-13fd23a1c082@intel.com>
Date:   Tue, 5 Jan 2021 09:56:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201228213338.e5tspbe3od27lo4x@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 12/28/2020 1:33 PM, Luc Van Oostenryck wrote:
> On Mon, Dec 28, 2020 at 05:18:50PM +0000, Ramsay Jones wrote:
>>
>>
>> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
>>> During parsing, Sparse recognizes the attribute 'packed' but this
>>> attribute is otherwise ignored for several reasons:
>>> 1) the attribute in 'struct __attr { ... }' is wrongly handled as
>>>    belonging to the whole declaration but it should belong to the type,
>>> 2) the attribute in 'struct <name> { ... } __attr;' is simply ignored,
>>> 3) the layout of packed bitfields need special care.
>>>
>>> This series contains 2 parts:
>>> 1) handling of type attributes
>>> 2) correct layout of packed structs, including packed bitfields.
>>>
>>>
>>> This series is also available for review and testing at:
>>>   git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git packed-v2
>>
>> I left a couple of minor comments, but (apart from patch #16) this
>> otherwise LGTM.
>>
>> Patch #16 also looks good, but I would need to study it a bit more
>> than I have time available to be totally happy. It does not seem
>> to be handling the 'lowering' of 'odd bit-sized' symbols created in
>> the previous patch (to answer my own question), so I would have to
>> apply the patches (or fetch the above branch) to study some more.
> 
> Well, patch #16 doesn't contain the lowering, it kinda just enables
> the last bits to support (without out-of-bound access) packed structures
> including packed bitfields.
> 


What does the 'lowering' gain us? Or, in other words, what is still
missing after this series?

>> Hope you had a good holiday.
> 
> Thank you. In truth, it was strange and quiet, very quiet.
> 
> I wish you all the best for 2021!
> 
> -- Luc
> 
