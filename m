From: Christopher Li <sparse@chrisli.org>
Subject: RFC: [0/2] Moving attribute data out of ctype
Date: Wed, 27 Feb 2013 07:13:53 -0800
Message-ID: <CANeU7Q=UNu=Jy5dfSp+3CpAHSn3onnB_TVBSqZdA=OypGkY8+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:40322 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab3B0PNx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Feb 2013 10:13:53 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so114984obc.6
        for <linux-sparse@vger.kernel.org>; Wed, 27 Feb 2013 07:13:53 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Al,

As we know "ctype" is a very common data struct, we don't want
to expand the size of ctype. It is running out of bits to proper
store fancy attribute data.

I want to store the attribute in a separate structure. The ctype
only keep a pointer to it. Most of the C code don't use attribute
at all. It will reuse the empty attribute pointer. I can grow that
attribute struct easier because only symbol that use the fancy
attribute will have the extra attribute structure allocated.

The first patch add the attribute structure, duplicating the attribute
in ctype. The second patch remove the reference of old attribute
member inside ctype.

What do you say about eventually move all the attribute bits
out of the modifiers into attribute struct? e.g. noreturn,pure etc.

Testing:
- make check passed.
- I run the patch against current Linux source tree. It produce the same
sparse checking output in all module configuration.

Thanks

Chris
