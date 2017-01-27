From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 19:22:21 +0000
Message-ID: <CACXZuxfi+TPJqtcvLC9Y9S_vfK9MTETi8LsngSOvNNMEtLY7Aw@mail.gmail.com>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
 <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
 <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com> <20170127190716.e7ux5guhg7sbomar@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34681 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdA0T3q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 14:29:46 -0500
Received: by mail-vk0-f52.google.com with SMTP id r136so182019782vke.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 11:29:16 -0800 (PST)
In-Reply-To: <20170127190716.e7ux5guhg7sbomar@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

I also notice that LLVM assertions fail on some of the existing
backend tests. I use a debug build of LLVM which has extra type
checking of LLVM IR.

My understanding of LLVM IR is that it requires types of operands to
be strictly the same or else there needs to be explicit conversions or
bitcasts. So for example, following fails in sparse-llvm:

struct foo {
 struct foo *p;
};
void test(struct foo *Foo);
void test(struct foo *Foo) {
 Foo->p = (struct foo *) 0;
}

Thanks and Regards
Dibyendu
