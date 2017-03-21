From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Possible linearizer issue
Date: Tue, 21 Mar 2017 15:34:31 +0000
Message-ID: <CACXZuxeomDxKsmdu7e5YEg_-3exNpV-psjQ_o3P0BLV1A2=z0Q@mail.gmail.com>
References: <CACXZuxeuav4vrT=xKxLcV7RpUET8NM7VLuviTNr4N_XfGQxmHQ@mail.gmail.com>
 <20170321150506.xev7tkmbrtjgncv6@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34458 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755420AbdCUPee (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 11:34:34 -0400
Received: by mail-io0-f172.google.com with SMTP id b140so50736491iof.1
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 08:34:33 -0700 (PDT)
In-Reply-To: <20170321150506.xev7tkmbrtjgncv6@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 21 March 2017 at 15:05, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 18, 2017 at 11:41:26AM +0000, Dibyendu Majumdar wrote:
>> I am investigating a failure in one of the tests. The generated
>> linearized code has instructions such as:
>>
>> .L363:
>>  br          VOID, .L366, .L439
>> .L366:
>>  load.32     %r413 <- 44[%arg1]
>>  br          %r413, .L368, .L369
>> .L368:
>>  load.64     %r415 <- 0[s7813er]
>>  call.32     %r416 <- printf, %r415, $2
>>  br          .L369
>> .L369:
>>  phisrc.32   %phi97(rc) <- $2
>>  br          .L439
>> .L439:
>>  phi.32      %r557 <- %phi95(rc), VOID, %phi97(rc), VOID, VOID, VOID
>>
>> The test program is here:
>>
>> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/set1/cq2.c
>
> I have looked a bit at this.
> Reverting the patch (11b1a83b1 "fix OP_PHI usage in try_to_simplify_bb()")
> should fix this but I'm not 100% sure about the consequence.
> I'm looking for a proper solution though (but it need a bit infrastructure
> code that I first need to put in place, so it will take a bit time).
>

I can confirm that removing that patch did fix the issue.

Thanks and Regards
Dibyendu
