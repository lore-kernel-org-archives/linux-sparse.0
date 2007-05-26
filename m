From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: pointer arithmetics and casts
Date: Fri, 25 May 2007 21:14:33 -0400
Message-ID: <118833cc0705251814h9fffa39xc4a0f3f9e61242b9@mail.gmail.com>
References: <20070525212300.GL4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:17685 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbXEZBOe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 21:14:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1245799ugf
        for <linux-sparse@vger.kernel.org>; Fri, 25 May 2007 18:14:33 -0700 (PDT)
In-Reply-To: <20070525212300.GL4095@ftp.linux.org.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

>         BINOP[+]
>                 <tree for p>
>                 BINOP[*]
>                         IMPLICIEDT_CAST[ptrdiff_t]
>                                 <tree for i>
>                         VAL[sizeof(*p)]

I don't think you want ptrdiff_t there.  It isn't guaranteed to
be big enough.

size_t should do, though.

M.
