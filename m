From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sun, 20 Aug 2017 16:45:33 +0200
Message-ID: <CAExDi1T5a_exYvJUT5G11URvETEv7TKYcrEj5CJFhBrH+_ZXGw@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
 <CACXZuxdO+pco93WYtbh4W95c6r+f9fp_85TFhQvn-8UOQvOBWw@mail.gmail.com>
 <CANeU7Q=x_DZzp93jP9AU5zpTuggR1AGa9pYqwi-kitXV5EKs0w@mail.gmail.com>
 <CACXZuxf-yb5WODCDJ2cQxJ2_sKUwSeKwAmOX+GHCWpd0qOvGvQ@mail.gmail.com>
 <CAMHZB6EqBouFuAMy+Nvr=XAJqxZBGgrRSzsz=zbhv-yQ6zLJtg@mail.gmail.com> <CACXZuxcez1YcYwY9SMW4mNpT-o3cm0C8u==QJFzfPvjehiBQ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35759 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbdHTOpe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 10:45:34 -0400
Received: by mail-oi0-f51.google.com with SMTP id e124so134374171oig.2
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 07:45:33 -0700 (PDT)
In-Reply-To: <CACXZuxcez1YcYwY9SMW4mNpT-o3cm0C8u==QJFzfPvjehiBQ2A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 2:33 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I think you are raising a deeply philosophical issue.

It was only a pragmatic issue.

> I firmly believe
> all tests are good and needed, and take the pragmatic view that I will
> use whatever tests I can lay my hands on.

Of course.

> Sure we want unit tests as
> these help debug problems. But these need to be written by whoever is
> developing a feature or enhancement. Perhaps Sparse should adopt the
> contribution policy that no changes should be accepted without
> accompanying unit tests.

Patches for the test suite are certainly most welcome.

-- Luc
