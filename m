From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 15:19:20 +0100
Message-ID: <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com> <20170328141113.kbrwdva6ttsrokts@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36105 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdC1O1s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:27:48 -0400
Received: by mail-it0-f49.google.com with SMTP id e75so57834727itd.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:27:33 -0700 (PDT)
In-Reply-To: <20170328141113.kbrwdva6ttsrokts@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 28 March 2017 at 15:11, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> The first instruction and.32 refers to %r4 which is undefined.
>
> Yes, I saw.
> This %r4 corresponds (somehow) to s3 which isn't initialized.
>
> But yes, there is two problems here:
> *) we should use something explicit, like VOID
> *) there is a circulary dependence between %r3 & %r4, the first %r4
>    being obviously wrong.
>
> I suspect there is a lot of problems present once there is some
> undefined variables.
>

Well the unsimplified output is correct. The problem appears after
simplification.

Regards
Dibyendu
