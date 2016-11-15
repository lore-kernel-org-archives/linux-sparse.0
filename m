From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH] bits_in_bool should be 8
Date: Mon, 14 Nov 2016 21:27:41 -0500
Message-ID: <1479176861.7928.3.camel@redhat.com>
References: <1479156643-28563-1-git-send-email-jlayton@redhat.com>
         <CANeU7QkTp9O3d4NP+9oW3CUdBvS6-65kByroYj-HhnPv5aUhBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5LLIhtVO2FyoqtFrQOa0"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33689 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754817AbcKOC1o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Nov 2016 21:27:44 -0500
Received: by mail-qk0-f172.google.com with SMTP id x190so119833946qkb.0
        for <linux-sparse@vger.kernel.org>; Mon, 14 Nov 2016 18:27:44 -0800 (PST)
In-Reply-To: <CANeU7QkTp9O3d4NP+9oW3CUdBvS6-65kByroYj-HhnPv5aUhBA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>


--=-5LLIhtVO2FyoqtFrQOa0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-11-15 at 08:23 +0800, Christopher Li wrote:
> On Tue, Nov 15, 2016 at 4:50 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > Given that we're working with byte-addressable machines, each type must
> > be at least one byte in size or you'd not be able to take a pointer to
> > it.
> > 
> > Noticed at random when I ran the sample "compile" program in the
> > sparse source tree vs. a test C program that uses bools. It crashes
> > without this patch.
> 
> Do you have the test program to crash sparse?
> 
> Sparse should handle bool size correctly. The bits_in_bool is
> a internal thing for sparse. From sizeof(bool) point of view,
> sparse should treat sizeof(bool) as 8 bits. But bool has only
> one bit usable value.
> 
> Chris

Attached. This is also the program I was using to track down the
storage_modifiers problem.

To be clear though, sparse doesn't crash here. I happened to run the
"compile" example program that's in the sources against it while poking
at the other problem and noticed that it crashed.

I don't think we really care much about "compile", but it looked like
it might be indicative of a problem in sparse itself.

-- 
Jeff Layton <jlayton@redhat.com>
--=-5LLIhtVO2FyoqtFrQOa0
Content-Disposition: attachment; filename="errtest.c"
Content-Type: text/x-csrc; name="errtest.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CgojZGVmaW5lIE1BWF9FUlJO
TyAgICAgICA0MDk1CiNkZWZpbmUgSVNfRVJSX1ZBTFVFKHgpICgoeCkgPj0gKHVuc2lnbmVkIGxv
bmcpLU1BWF9FUlJOTykKI2RlZmluZSBfX2ZvcmNlIF9fYXR0cmlidXRlX18oKGZvcmNlKSkKCnN0
YXRpYyBpbmxpbmUgYm9vbCBJU19FUlIoX19mb3JjZSBjb25zdCB2b2lkICpwdHIpCnsKICAgICAg
ICByZXR1cm4gSVNfRVJSX1ZBTFVFKCh1bnNpZ25lZCBsb25nKXB0cik7Cn0KCmludAptYWluKGlu
dCBhcmdjLCBjaGFyICoqYXJndikKewoJcmV0dXJuIElTX0VSUihOVUxMKTsKfQoK


--=-5LLIhtVO2FyoqtFrQOa0--

