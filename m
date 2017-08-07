From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: Sparse documentation format, rST vs MD
Date: Mon, 7 Aug 2017 10:25:32 -0600
Message-ID: <20170807102532.547fc0e2@lwn.net>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
        <20170807045611.aq3ofd57a7mtvdcm@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:59662 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbdHGQZd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 12:25:33 -0400
In-Reply-To: <20170807045611.aq3ofd57a7mtvdcm@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sun, 6 Aug 2017 21:56:12 -0700
Josh Triplett <josh@joshtriplett.org> wrote:

> I'm not sure
> why the kernel picked reStructuredText, but I don't think there's likely
> to be a huge amount of cross-pollination between the two in terms of
> documentation.

To address the "why the kernel picked RST" question, in case anybody's
curious...

We looked hard at MD, AsciiDoc, and RST; indeed, there were patches in
circulation for both MD and AsciiDoc before RST even entered the picture.
In the end RST won out because:

 - It allows the creation of large, integrated, multi-file documents.
   Every MD file is a world unto itself, and AsciiDoc is about the same.
   RST lets us put in nice things like global indexes and cross-references.

 - Some people want to do fancy tables.  It was argued that AsciiDoc is
   actually the best here; MD is not.

 - RST is actively developed and widely used.  AsciiDoc looks stale; MD is
   actively developed in a large number of mostly compatible variants.

 - Production of numerous output formats without the need for obnoxious
   toolchains.  This, alas, turned out not to be true for PDF output; if
   your docs are simpler, though, you might be able to use rst2pdf and
   avoid a lot of pain.

 - RST has a nice extension mechanism that makes it easy for us to add our
   own functionality.

...and probably something else I forgot.  

(I'm not arguing that sparse should or should not use RST, BTW, just
answering Josh's implied question for the kernel).

jon
