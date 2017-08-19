From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sat, 19 Aug 2017 10:46:01 +0100
Message-ID: <CACXZuxdO+pco93WYtbh4W95c6r+f9fp_85TFhQvn-8UOQvOBWw@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:37132 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdHSJqC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Aug 2017 05:46:02 -0400
Received: by mail-ua0-f178.google.com with SMTP id x35so4050892uax.4
        for <linux-sparse@vger.kernel.org>; Sat, 19 Aug 2017 02:46:02 -0700 (PDT)
In-Reply-To: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 19 August 2017 at 03:46, Christopher Li <sparse@chrisli.org> wrote:
> Another thing I just realized is that, this SSSA conversion
> only works for *local* variable, not C pointers?
> I want to construct some test source to verify.
> However it is not even working for the base case:

I think it is an excellent idea to create a bunch of careful tests to
assess / validate the changes. Perhaps the tests should cover various
scenarios including switch statements, gotos, computed gotos, looping
constructs, etc. And specific uses of globals, pointers, locals etc.

Thanks and Regards
Dibyendu
