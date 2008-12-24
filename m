From: "Christopher Li" <sparse@chrisli.org>
Subject: My sparse repository
Date: Wed, 24 Dec 2008 04:17:39 -0800
Message-ID: <70318cbf0812240417pc39e0c7gef1fd9c7ab0e14e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:4874 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYLXMRl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 07:17:41 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2828972rvb.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 04:17:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Josh Triplett <josh@freedesktop.org>, Rusty Russell <rusty@rustcorp.com.au>

HI,

I create a sparse repository at:

git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

It is mostly for patch which I consider candidates for the official
tree. Currently it only contain Johannes' context revert and a small
fix for Rusty's recent encounter of typeof. I will collect other patches
on the sparse mailing list if I see fit.

Josh, please consider pull.

Thanks

Chris

===================================

Christopher Li (1):
      Teach classify_type to handle typeof

Johannes Berg (1):
      Revert the context tracking code
