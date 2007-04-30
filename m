From: "Mike Goodwin" <mike.goodwin@cantab.net>
Subject: Style checking
Date: Mon, 30 Apr 2007 00:30:45 -0700
Message-ID: <c38fc0de0704300030x6ab610acge10482904056d1db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:48841 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423116AbXD3Haq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Apr 2007 03:30:46 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1837242nzf
        for <linux-sparse@vger.kernel.org>; Mon, 30 Apr 2007 00:30:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I have begun modifying sparse (read: adding in various hooks to the
preprocessing and parsing stages) in order to be able to use it as a
style checker. Checking rules such as order of includes, function and
variable naming ... etc.

The style checking is intended to be for linux/driver modules and as
far as I am aware the only two freely available c parsers which can
parse all the headers in the linux kernel are those that are part of
sparse and gcc. As sparse is a lot simpler to modify it seems the
logical choice

So I was wondering:-
 1) if anyone had used sparse similarly?
 2) would it ever be desirable to have this kind of feature as a part of sparse?
 3) is there anything wrong with this approach?!

- Mike
