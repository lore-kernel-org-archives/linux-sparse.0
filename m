From: "Dan Carpenter" <error27@gmail.com>
Subject: Re: Moving smatch to use sparse
Date: Thu, 5 Oct 2006 13:58:02 -0700
Message-ID: <a63d67fe0610051358j6181f558p2baaf1b59b0a042e@mail.gmail.com>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com>
	 <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com>
	 <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>
	 <45252A39.3050008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13748 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751303AbWJEU6E (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Oct 2006 16:58:04 -0400
Received: by ug-out-1314.google.com with SMTP id o38so253476ugd
        for <linux-sparse@vger.kernel.org>; Thu, 05 Oct 2006 13:58:02 -0700 (PDT)
In-Reply-To: <45252A39.3050008@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: smatch-discuss@lists.sourceforge.net, linux-sparse@vger.kernel.org

On 10/5/06, Michael Stefaniuc <mstefani@redhat.com> wrote:
> Hello Dan,
>
> Dan Carpenter wrote:
> > Work on smatch is going ahead.  I have one real life check is working
> > and I've added a patched up the core code quite a bit.
> great work! What about the old smatch.pm and perl scripts? Will i be
> still able to use those or would i have to port them over? I'm still
> using the old smatch on checking Wine.
>
> bye
>         michael
>

They'll have to be ported I'm afraid.

Rewrites are a pain, but it's worth it because now it's easier to
install, it's easier to use, and it runs a bajillion times faster.
Using sparse also buys us a bunch of features for free, for example if
you have 'i' defined in two different scopes with sparse handles that.
 Another example is compound conditions.  The old code was confused by
stuff like:
if (a && a->foo() || a && a->bar())
there wasn't a good way to deal with that with the old way.

Which checks do you use most?  I'll port those first...

regards,
dan carpenter
