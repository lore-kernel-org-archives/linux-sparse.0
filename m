From: Christopher Li <sparse@chrisli.org>
Subject: Re: [patches] more declarations fixes
Date: Mon, 9 Mar 2009 16:53:18 -0700
Message-ID: <70318cbf0903091653x2c67decfif0260aae1d176f80@mail.gmail.com>
References: <E1LgZcm-0000qk-0S@ZenIV.linux.org.uk>
	 <70318cbf0903091555t2f456476u16e06d642f1fd02@mail.gmail.com>
	 <20090309233211.GT28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:63132 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbZCIXxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 19:53:21 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1901617rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 09 Mar 2009 16:53:18 -0700 (PDT)
In-Reply-To: <20090309233211.GT28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Mon, Mar 9, 2009 at 4:32 PM, Al Viro <viro@zeniv.linux.org.uk> wrote=
:
> BTW, what in the name of everything unholy have you got in
> validation/static-forward-decl.c? =A0Misplaced error line?

Err, that is obvious a screw up from my side. It just happen on a file
supposed to fail so I did not notice it. I will clean it up.

Thanks for point it out.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
