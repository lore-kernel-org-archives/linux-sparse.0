Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFCEC4332E
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B6222D75
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 22:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbhAEWIm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 5 Jan 2021 17:08:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:12556 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbhAEWIl (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 5 Jan 2021 17:08:41 -0500
IronPort-SDR: F8SstZ3hyMEa0wAuvNjLVH53sOD8snxrcjyidyNl4ZA+CfR7ZpUqTzfAJTNxRJpJSTci0G6c59
 cCoDWLHecqdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="177287375"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="177287375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 14:08:00 -0800
IronPort-SDR: 2Tf2L8N+BqIDMK0TiKXbRRO7XO7jbFYOoq+F2OBd87gkkbOTw7rcL65LCwbrSQjE0XAzHyzG9p
 dHVsdMNhLjDw==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="350011825"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.212.7.147]) ([10.212.7.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 14:08:00 -0800
Subject: Re: [PATCH 00/16] support __packed struct
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        linux-sparse@vger.kernel.org
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <6a00eea2-7371-de84-05fc-1375603ed7eb@ramsayjones.plus.com>
 <20201228213338.e5tspbe3od27lo4x@ltop.local>
 <49f5ad45-5776-ab70-53c9-13fd23a1c082@intel.com>
 <20210105203909.vnuhix3ukl7zxgt6@ltop.local>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <70519c76-29df-bc72-d3ad-81c53dcb8a47@intel.com>
Date:   Tue, 5 Jan 2021 14:07:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105203909.vnuhix3ukl7zxgt6@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 1/5/2021 12:39 PM, Luc Van Oostenryck wrote:
> On Tue, Jan 05, 2021 at 09:56:05AM -0800, Jacob Keller wrote:
>> On 12/28/2020 1:33 PM, Luc Van Oostenryck wrote:
>>> On Mon, Dec 28, 2020 at 05:18:50PM +0000, Ramsay Jones wrote:
>>>>
>>>> Patch #16 also looks good, but I would need to study it a bit more
>>>> than I have time available to be totally happy. It does not seem
>>>> to be handling the 'lowering' of 'odd bit-sized' symbols created in
>>>> the previous patch (to answer my own question), so I would have to
>>>> apply the patches (or fetch the above branch) to study some more.
>>>
>>> Well, patch #16 doesn't contain the lowering, it kinda just enables
>>> the last bits to support (without out-of-bound access) packed structures
>>> including packed bitfields.
>>>
>>
>> What does the 'lowering' gain us? Or, in other words, what is still
>> missing after this series?
> 
> As a static checker, nothing is missing and the series is now mainlined.
> 
> The 'lowering' only matters if you want to somehow translate the
> instructions used in the IR (Intermediate Representation) into
> instructions for a more concrete machine, because now there are things
> like: 'do a load of a 5-byte word'.
> 
> -- Luc
> 

Ok thanks, that makes sense.

- Jake
