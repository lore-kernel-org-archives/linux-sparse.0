From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Tue, 7 Mar 2017 00:22:07 +0800
Message-ID: <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com> <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37985 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbdCFQaG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 11:30:06 -0500
Received: by mail-it0-f54.google.com with SMTP id m27so53544141iti.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 08:30:05 -0800 (PST)
In-Reply-To: <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 6, 2017 at 11:32 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Sparse-llvm appears to bypass the normal struct GEP in LLVM. It
> basically casts everything to char *, uses GEP to obtain a pointer to
> member, and then casts it back to member type. So this should work for
> structs and unions.

That is exactly my question. I haven't understand how this by pass
can work in all the situation.

>
> This case is more about handing pointer arithmetic correctly. Here GEP
> is being used as array element access and not for struct member
> access.

Even using array element access, I still have some question regarding
the the mapping process of the array index.
Correct me if I am wrong, the GEP indices are express as array index.
So after convert to (char*) + offset, the offset will express as
n*(sizeof(element type)).
"n" is the array index.

However, the OP_ADD instruction, the offset is byte offset value. The offset
part might not be align to n*(sizeof(array_elelment)). Assume we can use
some pack struct to get some member located not at the natural alignment offset.

Even if the offset is at the type size alignment, shouldn't the indices express
as ( offset / sizeof(element type))? What do I miss?

Chris
