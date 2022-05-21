Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAEBC433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 15:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiEUPvT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355429AbiEUPvL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 11:51:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A47113E20
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ze8vQ1uT3+kcNBKHsZh43/FduhaTzLrf26TNMNd1Cr0=; b=AWfyp4pH5ur1baOvncn9CzKkp9
        /2P51O9KfGzdpDDX1ah9nyVJ4gS5oiKlnoaWJs7AxXsR5zSCGfvp9KZ+c8l7rmd/PNwbO4+nPZBNU
        nm6biIOsN+am+rc5fBZCtBFnuARVGt+Jn/sxLP90TD8Y0K9R3TDwx31pyGXoKeSMojvKN+KoMpYeS
        obvUVoCpZ1FCRttkmUoIZaukj0L1GjsVPxS0r0QVsEM9ORluDNxiax9NqjCWUvCAmsZscMrlmPDgF
        J/ebn9JWD8HCyY999FGomBrzTOftFY62JekR0T5uS4hZXsKoEKGYYWDIhVS1R6dC3SifDp5eSelYX
        m5uDzMQw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsRNh-00EkFS-Lc; Sat, 21 May 2022 15:51:05 +0000
Message-ID: <7a38638d-8d91-b86c-b24c-8db21e46b83d@infradead.org>
Date:   Sat, 21 May 2022 08:51:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: sparse v0.6.4
Content-Language: en-US
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
References: <e9edc9f5-9b88-4a6a-17f8-544270ec2450@ramsayjones.plus.com>
 <33a053bc-1d81-49f4-0c8a-879a5519c433@infradead.org>
 <20220521135428.g5l47v2lsltv7lod@mail>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220521135428.g5l47v2lsltv7lod@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 5/21/22 06:54, Luc Van Oostenryck wrote:
> On Fri, Jan 14, 2022 at 08:25:31PM -0800, Randy Dunlap wrote:
>> Hi Luc,
> 
> Hi Randy,
> 
> Apologies for this reply delayed for much too long.

Hey Luc,

>  
>> It seems that $subject version adds builtins for ATOMIC_ACQUIRE and
>> ATOMIC_RELEASE, but GCC has those too, so there are a few thousand
>> (OK, I didn't count them - I killed it quickly) of these: (e.g.)
> 
> Yes indeed, it was one of the things added in this release.
>  
>> ..  CHECK   ../init/do_mounts_initrd.c
>> .command-line: note: in included file:
>> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_ACQUIRE redefined
>> builtin:0:0: sparse: this was the original definition
>> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_SEQ_CST redefined
>> builtin:0:0: sparse: this was the original definition
>> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_ACQ_REL redefined
>> builtin:0:0: sparse: this was the original definition
>> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_RELEASE redefined
>> builtin:0:0: sparse: this was the original definition
>>
>> Any suggestions for how to avoid these warnings?
> 
> Do you still see these? If yes, can you tell a bit about your setup and
> the exact command line used?

No, I no longer see these warnings. :)

> I'm asking because I never saw a problem with this, same for the test bots.
> It should be exactly the same as for any other predefined value.
> However, as predefined, they should all be reported from 'builtin:0:0:'
> and the 'builtin:1:9:' look as if those are from a '-include <somefile.h>'
> on the command line.
> 
> Best regards,
> -- Luc

Thanks.

-- 
~Randy
