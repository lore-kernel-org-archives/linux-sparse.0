From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 08:26:28 -0400
Message-ID: <118833cc0705230526o46eb1633i69a12219f24c1343@mail.gmail.com>
References: <20070519025249.GZ4095@ftp.linux.org.uk>
	 <4653633B.3000000@freedesktop.org>
	 <20070522224619.GI4095@ftp.linux.org.uk>
	 <46537BC1.9000808@freedesktop.org>
	 <20070523000234.GJ4095@ftp.linux.org.uk>
	 <20070523002506.GK4095@ftp.linux.org.uk>
	 <20070523045319.GL4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:64635 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757870AbXEWM0a (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 08:26:30 -0400
Received: by ug-out-1314.google.com with SMTP id j3so494749ugf
        for <linux-sparse@vger.kernel.org>; Wed, 23 May 2007 05:26:28 -0700 (PDT)
In-Reply-To: <20070523045319.GL4095@ftp.linux.org.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

>[...] but $DEITY help you if you pass NULL
> in vararg in place of pointer to function - on minimally weird targets
> it will be ugly.  I don't think that sparse can catch that kind of
> braindamage, though...

If the rules for the types in any given function's varargs can be taught to
sparse, I don't see why not.  I did some vararg checking -- "must end with
-1" kind of thing -- early for sparse.  It should be in the archives.  (An
early prototype with sub-standard monkey-see-monkey-do coding, but
still.)

Morten
