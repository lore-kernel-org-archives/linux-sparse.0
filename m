Return-Path: <SRS0=2wv3=EB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91230C4363A
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 23:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D07F207F7
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 23:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404510AbgJZXWS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:22:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38591 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404241AbgJZXWR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Oct 2020 19:22:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so1138595plr.5
        for <linux-sparse@vger.kernel.org>; Mon, 26 Oct 2020 16:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XjCSNdOCcDZ33V8a0yf/WmYuoZgeAeOmDmE7vJ+/UII=;
        b=nnGoYIhVEGmV+piQwLY6jpHw464ynIw2pmH7QYUOwXlYM/4gW8m3dkZEk4fLKWYvsN
         +ciUvzywMcziy0TPVVWmRhjCYSXb+l/hQ5+gtHUc8gm7Yn+CEBVdcTmr/pGOREdgMuU4
         z9KyWi1ZUxHk5+sR6zzAinR+vJREXTx+5Jl/gCuB/2DjNJcRY2x9t7LMYcJMZq5wkU5M
         8GIpm1UoQ0ghVmpkNnf4NUonQ67vlK2XVmincQgjqEQ1x426etLR7u4AVh3p243zLze+
         EhuBTbeOlSdBpfd1OTO53gnDp6gRFd8axya2Aw93m6yOGN86Yjc8pCRxgd/QfOCQzLqR
         XulQ==
X-Gm-Message-State: AOAM531P3XlG21P6Vsx1k50A3Becced92zgYrZtHwbvBiu3RS7QUajYF
        1NrtOwmhqKbily8cdDRmWnp84+CRXuz4cw==
X-Google-Smtp-Source: ABdhPJx6COms/GlXsFHC+jRrIhQXMbTJ4l2WaAK6JDMCEogPg0572uiQJ7dSrGR9uLaozc+0wUnNvA==
X-Received: by 2002:a17:90a:7787:: with SMTP id v7mr19122774pjk.104.1603754536380;
        Mon, 26 Oct 2020 16:22:16 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q189sm4100453pfc.94.2020.10.26.16.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 16:22:15 -0700 (PDT)
Subject: Re: [PATCH] handle more graciously labels with no statement
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arun Easi <aeasi@marvell.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
References: <20201026045338.55218-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wigYApoRH_LS2wu-i7fNp0wF1eJz27od02oo124qXvBjw@mail.gmail.com>
 <20201026204847.h3uokzvm74g5ykcn@ltop.local>
 <CAHk-=wh2ta_qhejh1C87sZcz09MfNTtxYU8EFy4zKQ0zQfVY=w@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3abeaeef-ddde-5c47-f79b-4c61a0820c08@acm.org>
Date:   Mon, 26 Oct 2020 16:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh2ta_qhejh1C87sZcz09MfNTtxYU8EFy4zKQ0zQfVY=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 10/26/20 3:56 PM, Linus Torvalds wrote:
> On Mon, Oct 26, 2020 at 1:48 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> On Mon, Oct 26, 2020 at 10:41:36AM -0700, Linus Torvalds wrote:
>>> But can you point to the actual 5.10-rc1 problem? I haven't seen the
>>> report, and afaik gcc will complain about this too ("label at end of
>>> compound statement") so I'm surprised sparse hits it..
>>
>> Well, I was surprised it wasn't caught and was ready to send a patch
>> but it can only happen when using sparse, see below, quite ironic:
>>         drivers/scsi/qla2xxx/qla_tmpl.c:1052.
>>         1050         }
>>         1051
>>         1052 bailout:
>>         1053 #ifndef __CHECKER__
>>         1054         if (!hardware_locked)
>>         1055                 spin_unlock_irqrestore(&vha->hw->hardware_lock, flags);
>>         1056 #endif
>>         1057 }
> 
> Yeah, that "don't sparse this" pattern has been problematic before.
> 
> I removed it.
> 
> Bart, Arun - see commit 4525c8781ec0 ("scsi: qla2xxx: remove incorrect
> sparse #ifdef").

Hi Linus,

Thank you for having Cc-ed me. I agree that it's better to make the
kernel code compliant with the C standard than to make sparse accept
non-standard code.

The #ifndef __CHECKER__ / #endif that I added in 2015 in the above code
(commit 8d16366b5f23) was added because at that time I didn't see a
better solution.

BTW, personally I'm neither enthusiast about #ifndef __CHECKER__ /
#endif nor about if (expression) <locking statement>.

Bart.
