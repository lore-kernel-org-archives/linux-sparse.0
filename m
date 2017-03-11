From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect handling of function pointers
Date: Sat, 11 Mar 2017 12:54:18 +0100
Message-ID: <20170311115418.wwuvklkphmwfzom4@macbook.local>
References: <CACXZuxeHAXK11Tyx0PSg_uqDo0rZ3Cw+aZ5gN1S_LpPMZG8cCQ@mail.gmail.com>
 <20170310174445.4fmyibgvl7yyaz2s@macbook.local>
 <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38330 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCKLyW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 06:54:22 -0500
Received: by mail-wm0-f42.google.com with SMTP id t189so11624312wmt.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 03:54:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 10, 2017 at 06:13:16PM +0000, Dibyendu Majumdar wrote:
> Yes, here is an amended test.
> 
> static int testfunc(int i) {
>  return i-6;
> }
> static int (*f) (int) = testfunc;
> int main(int argc, const char *argv[]) {
>  if (f) {
>   return f(6);
>  }
>  else {
>   return 1;
>  }
> }

This one is because of the static initialization.

> I am creating a bunch of tests that can be run after compiling.

Excellent, they are really needed.

> The current backend tests are not very useful as they do not actually run
> or validate the results.

Yes, indeed.

-- Luc Van Oostenryck
