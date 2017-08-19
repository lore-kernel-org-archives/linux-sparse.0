From: Christopher Li <sparse@chrisli.org>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sat, 19 Aug 2017 06:56:44 -0400
Message-ID: <CANeU7Q=x_DZzp93jP9AU5zpTuggR1AGa9pYqwi-kitXV5EKs0w@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
 <CACXZuxdO+pco93WYtbh4W95c6r+f9fp_85TFhQvn-8UOQvOBWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36355 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbdHSK4p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Aug 2017 06:56:45 -0400
Received: by mail-yw0-f178.google.com with SMTP id c206so2237301ywb.3
        for <linux-sparse@vger.kernel.org>; Sat, 19 Aug 2017 03:56:45 -0700 (PDT)
In-Reply-To: <CACXZuxdO+pco93WYtbh4W95c6r+f9fp_85TFhQvn-8UOQvOBWw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 8/19/17, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I think it is an excellent idea to create a bunch of careful tests to
> assess / validate the changes. Perhaps the tests should cover various
> scenarios including switch statements, gotos, computed gotos, looping
> constructs, etc. And specific uses of globals, pointers, locals etc.
>

That is the idea for the test suite. To test how sparse handle
different source code.

There is also the idea of the debug version of sparse. Instead
having the fix input source. It will do dynamic verification
of sparse at run time. e.g. If there is a slow and reliable way
to generate SSA conversion. Then in the debug version will do
both the slow and reliable way and the new fast and optimal way.
Then compare notes to draw conclusion that the new way *is* better.
AT least not worse than the old way. In this case I want to verify
that, the new method at least cover all the variable converted
by the old method. Including variable used by pointers.

Chris
