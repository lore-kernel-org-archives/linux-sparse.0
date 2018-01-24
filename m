From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Wed, 24 Jan 2018 11:13:29 -0800
Message-ID: <CANeU7QmOOS3sMWN+4k9RRED4dz=XBjXJszfPQSXQU0G9jgatCw@mail.gmail.com>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
 <20180124082814.a36sur5e7cusrleb@ltop.local> <bb561f3d-342c-4f6c-5309-e16aa6fdafa4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:35969 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeAXTNa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 14:13:30 -0500
Received: by mail-qt0-f177.google.com with SMTP id z11so13176922qtm.3
        for <linux-sparse@vger.kernel.org>; Wed, 24 Jan 2018 11:13:30 -0800 (PST)
In-Reply-To: <bb561f3d-342c-4f6c-5309-e16aa6fdafa4@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jan 24, 2018 at 9:48 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> I don't think that will fix the original problem that I posted the
> patch for.

Agree, as long as the $quiet is set inside do_test(), any call to
error() out side
of do_test() will cause error. That is the original problem.

Chris
