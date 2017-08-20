From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 16:16:03 +0100
Message-ID: <ccf4cac2-003f-f856-28db-49dacae374b6@knosof.co.uk>
References: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
 <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from know-smtprelay-omc-8.server.virginmedia.net ([80.0.253.72]:59510
        "EHLO know-smtprelay-omc-8.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbdHTPY0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 11:24:26 -0400
In-Reply-To: <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Christopher,

> Because "hello" is array of char from type point of view.
> 
> It is same as
> char no_ident [] = {'h', 'e', 'l', 'l', 'o', '\0'};

You forgot the static keyword:
Sentence 903:
http://c0x.coding-guidelines.com/6.4.5.html

But depending on context a conversion occurs.
Sentence 729:
http://c0x.coding-guidelines.com/6.3.2.1.html

and your example is one where such a conversion occurs.

-- 
Derek M. Jones           Software analysis
tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
