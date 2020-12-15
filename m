Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8799CC4361B
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5296522D02
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 22:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgLOWpD (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:45:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:29285 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgLOWpB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Dec 2020 17:45:01 -0500
IronPort-SDR: cjRFWNMcRiHQj4pHVzZPIgnMDXijbCg4HKSczxoVy950OBoZNqEAtLQ5HlcbLV8Ah6KbD1iCYM
 Ffl5aNKhrzHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="239062632"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="239062632"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 14:44:21 -0800
IronPort-SDR: FvuBNszznXHQ5E2qEtNdHL+b5A+eSpO7xJQ6yZfjhHhoSAtBAk7/OlKULN+6C8/Na+UrdxEpAP
 GmLVl27oFh+A==
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="368497085"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.209.14.218]) ([10.209.14.218])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 14:44:21 -0800
Subject: Re: sparse attribute packed on structures
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
 <20201215205618.scarwvtzzhhtdwvk@ltop.local>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <d0db0ff6-0a57-0a20-9175-a9baaed9d9a0@intel.com>
Date:   Tue, 15 Dec 2020 14:44:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215205618.scarwvtzzhhtdwvk@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 12/15/2020 12:56 PM, Luc Van Oostenryck wrote:
> On Tue, Dec 15, 2020 at 10:15:35AM -0800, Jacob Keller wrote:
>> Hi,
> 
> Sorry, I don't have much time for this now but at first sight your patch
> seems on the right track. I can look at it more closely this WE but
> meanwhile I've pushed a branch 'packed' on
> 	git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git
> 
> This branch contains an unfinished patches but it should more or less
> handle the points 1) & 2) and circumvent point 3) by disabling access
> checking for bitfields.
> 

This branch solved my problem, and does it in a much more elegant way
than I was.

It still needs work for the issue of access, but the rest of the changes
did look good to me.

> I hope this will help you,
> -- Luc
> 
