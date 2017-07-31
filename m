From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 0/7] fixes for rare issues
Date: Mon, 31 Jul 2017 23:54:12 +0200
Message-ID: <CAExDi1TQh2kFXbyMgX_1tTG0b2F-k-_+CNDJeiKiBW0T0Q4nEA@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com> <CANeU7Qk4cRLtKmPxSVCEe9WJLEb8VajdCiokNV=ic4YALvKcqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35735 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaVyN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 17:54:13 -0400
Received: by mail-qt0-f169.google.com with SMTP id p3so114148213qtg.2
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 14:54:13 -0700 (PDT)
In-Reply-To: <CANeU7Qk4cRLtKmPxSVCEe9WJLEb8VajdCiokNV=ic4YALvKcqw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Jul 31, 2017 at 11:01 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Jul 31, 2017 at 4:36 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> This series contains some fixes for crashes I found during
>> some fuzzy-testing, as well as for some infinite loops
>> that may happen during simplification.
>
> Thank you so much for the patch.
>
> I have to ask, is it for review (for now) or request to pull to
> sparse-next (drop the previous version in sparse-next)?

It's for review & test as one patch is really changed and two
are new and while small induce big changes.

-- Luc
