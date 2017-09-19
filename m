From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] use shorter name for constexpr tests
Date: Tue, 19 Sep 2017 14:30:27 +0200
Message-ID: <CAExDi1QXyFoeL5qMaR8H0wEx_+6rCEo37Vni_qc68UUPXK7BQA@mail.gmail.com>
References: <20170915065347.6772-1-luc.vanoostenryck@gmail.com> <CANeU7QkJR97fZ8OJHKU4uzFTa9ryiapUGRgfcCV=9iKYakbMnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:46469 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbdISMa2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 08:30:28 -0400
Received: by mail-it0-f41.google.com with SMTP id 6so1665258itl.1
        for <linux-sparse@vger.kernel.org>; Tue, 19 Sep 2017 05:30:28 -0700 (PDT)
In-Reply-To: <CANeU7QkJR97fZ8OJHKU4uzFTa9ryiapUGRgfcCV=9iKYakbMnQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 19, 2017 at 2:20 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Sep 15, 2017 at 2:53 AM, Luc Van Oostenryck wrote:
>> The name used for these tests, while very correct, are a bit
>> longuish. They generaly take more than one line on the screen
>> which is annoying when running the testsuite.
>>
>> Change this by using shorter names for these tests.
>
> Looks good. I assume that is for review only.
> It will show up in the git pull some where right?

Yes, I'm busy to put together pending patches because I have
way too much of them (about 300 patches, without anything related
to SSA conversion or cast rework).

I'm posting stuff I haven't yet and will send a pull request later.

-- Luc
