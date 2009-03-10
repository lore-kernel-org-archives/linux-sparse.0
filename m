From: Christopher Li <sparse@chrisli.org>
Subject: Re: [patches] more declarations fixes
Date: Tue, 10 Mar 2009 14:27:26 -0700
Message-ID: <70318cbf0903101427y238844d9xfa19baa8c637437e@mail.gmail.com>
References: <E1LgZcm-0000qk-0S@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:37834 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbZCJV11 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 10 Mar 2009 17:27:27 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2399481rvb.1
        for <linux-sparse@vger.kernel.org>; Tue, 10 Mar 2009 14:27:26 -0700 (PDT)
In-Reply-To: <E1LgZcm-0000qk-0S@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Mon, Mar 9, 2009 at 12:10 AM, Al Viro <viro@ftp.linux.org.uk> wrote:
>
> OK, that pile ought to take care of a lot of nastiness. =A0We still h=
ave
> rather messy crap in attributes' handling, but it's actually getting
> cleaner now. =A0In particular, direct_declarator and declaration_spec=
ifiers
> are relatively sane, handling of type specifiers should be correct no=
w (and
> much cleaner than it used to be) and most of the tangled mess around
> attributes is untangled. =A0Still a mess, but at least doing somethin=
g
> about it becomes feasible...
>

I really like these series of patches. All applied.

It is much cleaner now.

BTW, what does Set_S and Set_T means? Symbol and type?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
