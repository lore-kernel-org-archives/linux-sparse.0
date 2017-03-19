From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm functions must be cast to correct type before calling
Date: Sun, 19 Mar 2017 01:20:14 +0100
Message-ID: <20170319002014.p2yah76w6ww35crr@macbook.local>
References: <CACXZuxcmizMoxj=xGAJYbbEbCHQC=4E7spC4MUqT1=0d+-NiAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35672 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdCSAUT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 20:20:19 -0400
Received: by mail-wr0-f170.google.com with SMTP id g10so72071713wrg.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 17:20:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcmizMoxj=xGAJYbbEbCHQC=4E7spC4MUqT1=0d+-NiAw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 16, 2017 at 08:58:25PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> The following test (adapted from snippet posted by Linus) fails in sparse-llvm:

...
 
> To resolve this before calling a function we need to cast it to the
> expected type. This can be done like this in output_op_call():

This is a very general problem with sparse-llvm, directly caused
by the fact the sparse associates type to instructions and LLVM
to the values.

What's happening is that the first time a pseudo is used
it's a value is created (with the curret type, of course)
*and* is stored in the pseudo::priv.
The next times this pseudo is used the LLVM value is directly
taken from the ::priv without regards for the current type.

In the coming update of the LLVM serie, I added an helper
for this sort of things: adjust_type(). But it need to be
added at the right place(s).

-- Luc
