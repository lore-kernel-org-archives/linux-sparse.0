From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] normalize bb's label names for testing
Date: Tue, 22 Nov 2016 18:02:04 +0800
Message-ID: <CANeU7Q=uNLQh=ynnWPeO0+ahu7qhJ2nxqxOrxbDraR1jo6xEAQ@mail.gmail.com>
References: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34858 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755700AbcKVKCG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 05:02:06 -0500
Received: by mail-io0-f193.google.com with SMTP id h133so9374364ioe.2
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 02:02:05 -0800 (PST)
In-Reply-To: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 21, 2016 at 12:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> These two patches solves the testing problem of the label names
> as emitted by test-linearize and others being not comparable
> between runs.

I think it is much easier just let test-linearize print out label in
a predictable way. e.g. In the "struct basic_block", there is this
two fields "generation" and "priv". The "generation" is used by
flow analyze to store some state. Same as the "priv", which is
used by the back end to store some back end related state.

Since test-linearize can treat as a back end, it is perfectly safe
to store some allocation number into the "priv".

Than we don't need to complicate the test-suit script to do the
label normalization.

Chris
