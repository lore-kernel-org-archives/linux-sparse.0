From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-llvm test cases
Date: Thu, 10 Aug 2017 14:01:10 -0400
Message-ID: <CANeU7QmFK3oK9iPcayvQphEWG+rBGn6uQoMeemAq3pJ7JV0AUw@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35315 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdHJSBL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 14:01:11 -0400
Received: by mail-yw0-f175.google.com with SMTP id l82so9349907ywc.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 11:01:11 -0700 (PDT)
In-Reply-To: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sun, Mar 12, 2017 at 9:13 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi
>
> As a measure of the progress made in the past few days (thanks Luc!) -
> I have a bunch of test cases that now pass. More tests will be added.
>
> Note that there are fixes in my project related to handling of fpcast,
> setval, and local variables that are not yet reflected in sparse code
> so these tests will not pass yet in sparse.
>
> The tests that pass are here:
>
> https://github.com/dibyendumajumdar/dmr_c/tree/master/tests

Again, sorry I am not able to response to it earlier. I am in the catching
up backlog mode now.

For those test case. I think it is very welcome to integrate into sparse.

If you want, you can break them down to smaller, digestible piece
and start submitting to sparse as patch series for review, or git pull
request. It will not get pull into this release v0.5.1 for sure. We can
start the discussion now. I can even have a post release branch doing
the merges for the patches after the release.

> These are not exactly in the format currently used for testing sparse.
> It will be nice however to add all the test cases to the official
> sparse repository.

That is fine. If it is all just test cases, that is relative safe.
Luc has a hue pile of pending patches I want to merge. If you touch
some of those core components, which result in Luc need to fix up
his repository a lot, then I would say hold a little bit for Luc's patches
being merged. The test case should be more or less fine.

Thank you

Chris
