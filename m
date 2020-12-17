Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2052C4361B
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Dec 2020 00:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC112376E
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Dec 2020 00:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgLQAoI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 16 Dec 2020 19:44:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:42065 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgLQAoI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Dec 2020 19:44:08 -0500
IronPort-SDR: csg2SVsaBmf2FL0cE36ZhAY//XJr8wMstIEK7h6+oSI95tM9dky5hbsGn9NGqbZkjpan0dQw1R
 H0AGNFtfvhvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="175266752"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="175266752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:43:27 -0800
IronPort-SDR: iFiVtfGeN3oqC65f9QCGQ8F/Wod7g5wm7+auKjoqpW76LUzrZJHuCMDo0xDjkK+j7oHA+wSRu8
 DrYK5DQaFc8A==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="369435906"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.252.136.67]) ([10.252.136.67])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:43:27 -0800
Subject: Re: sparse attribute packed on structures
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
 <20201215205618.scarwvtzzhhtdwvk@ltop.local>
 <76c27364-e4cb-cdd4-6e55-178dd19c46ba@intel.com>
 <20201216233021.qcnvgsup7efwanqs@ltop.local>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <09a4e340-76d4-9ae3-ffe3-6e44706200ae@intel.com>
Date:   Wed, 16 Dec 2020 16:43:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201216233021.qcnvgsup7efwanqs@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 12/16/2020 3:30 PM, Luc Van Oostenryck wrote:
> On Tue, Dec 15, 2020 at 03:15:48PM -0800, Jacob Keller wrote:
>>
>> I did find one bug, in your step (3), you have a check against
>> info->packed on symbol.c:162 in lay_out_struct, but nothing ever set the
>> packed value. I think you just need to initialized info->packed from
>> sym_packed at the top of examine_struct_union_type, i.e.
> 
> A yes, I see, thank you. I think it was on purpose that it wasn't
> yet enabled (things are it fuzzy because the code is ~2 year old)
> and as I said it's unfinished.
> 
> But, with your change, does it handles 'packed' more or less
> correctly?
> 
> -- Luc
> 

Yes. Obviously we're limited in that we no longer check for
out-of-bounds accesses on bitfields, but it at least produces the
correct sizes for structures, and avoids the warnings that I was running
into.

Overall, I think the changes in that branch are solid, and look correct
to me.

I'm not sure what all the limitations are of having it produce incorrect
load/store operations that don't work with the packed bitfields.. but at
least for the code I was checking, it seems to be correct now.

Thanks,
Jake
