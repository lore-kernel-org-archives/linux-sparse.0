From: "Mish Mash" <khalota@gmail.com>
Subject: looking for any examples of using sparse
Date: Wed, 9 May 2007 16:32:30 +0200
Message-ID: <bb2368c50705090732w4948fcc0ka3aea74ba22945b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:12338 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbXEIOcc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 May 2007 10:32:32 -0400
Received: by wr-out-0506.google.com with SMTP id 76so234370wra
        for <linux-sparse@vger.kernel.org>; Wed, 09 May 2007 07:32:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

dear all,

I'm trying to use sparse for writing various source code analysis
tools (I was using ctool previously). I'm currently going through the
source trying to figure out what I need. Given the excessive amounts
of comments I'm having to wade through, this probably isn't the
fastest way of figuring the beast out ;)

Does anyone have any notes they've taken or can point me at code that
uses sparse to help get a rough idea of how to use the beast? (Ideally
slightly more detailed than Randy Dunlap's howto) I noticed smatch now
uses sparse and i've applied their patch which I'm going over. Is
there anything better? (I've already found the no longer very useful
presentation at http://developer.osdl.org/dmo/sparse/)

Thanks!
nessim
