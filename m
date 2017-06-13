From: Christopher Li <sparse@chrisli.org>
Subject: Re: c2xml uses out of type modifiers mapping
Date: Tue, 13 Jun 2017 15:16:05 -0700
Message-ID: <CANeU7Qm2nkZCDtUf1Vb2EdMCuYstc6j4Wd6tqAWyKwDH9-E-RA@mail.gmail.com>
References: <CACXZuxeVo=5Lz2idvtbeHjLJHLZ4gPissRVfCyDAsKw1mKPRTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35978 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753866AbdFMWQG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 18:16:06 -0400
Received: by mail-io0-f179.google.com with SMTP id y77so82455628ioe.3
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 15:16:06 -0700 (PDT)
In-Reply-To: <CACXZuxeVo=5Lz2idvtbeHjLJHLZ4gPissRVfCyDAsKw1mKPRTw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 13, 2017 at 3:02 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I noticed that the mapping for type modifiers in c2xml is out of sync
> with the MOD_* definitions in symbol.h.

Do you mean in function examine_modifiers(), the modifiers[] array
are out of sync? It does look like so.

Patch is welcome :-)

Chris
