From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm test cases
Date: Fri, 11 Aug 2017 00:41:14 +0200
Message-ID: <CAExDi1R33RtEh0FU+_dTsrubBuAjjP7vPWJy1-H93fxiVQnhGw@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7QmFK3oK9iPcayvQphEWG+rBGn6uQoMeemAq3pJ7JV0AUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32958 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdHJWlP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 18:41:15 -0400
Received: by mail-oi0-f54.google.com with SMTP id f11so19987251oic.0
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 15:41:15 -0700 (PDT)
In-Reply-To: <CANeU7QmFK3oK9iPcayvQphEWG+rBGn6uQoMeemAq3pJ7JV0AUw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 8:01 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Mar 12, 2017 at 9:13 PM, Dibyendu Majumdar wrote:
>
> For those test case. I think it is very welcome to integrate into sparse.

Sure. Very welcome.

> If you want, you can break them down to smaller, digestible piece
> and start submitting to sparse as patch series for review, or git pull
> request. It will not get pull into this release v0.5.1 for sure. We can
> start the discussion now. I can even have a post release branch doing
> the merges for the patches after the release.
>
>> These are not exactly in the format currently used for testing sparse.
>> It will be nice however to add all the test cases to the official
>> sparse repository.
>
> That is fine. If it is all just test cases, that is relative safe.
> Luc has a hue pile of pending patches I want to merge. If you touch
> some of those core components, which result in Luc need to fix up
> his repository a lot, then I would say hold a little bit for Luc's patches
> being merged. The test case should be more or less fine.

Yes, in no ways should additional test cases be a problem.

-- Luc
