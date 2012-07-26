From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Adding default for m64/m32 handle
Date: Thu, 26 Jul 2012 10:45:54 +0300
Message-ID: <20120726074554.GM4403@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:23356 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab2GZHqI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jul 2012 03:46:08 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Hi Chris,

The patch 7aa79f8401f0 "Adding default for m64/m32 handle" causes
a problem for variables called x86_64.

$ echo "unsigned char x86_64;" > test.c
$ ./sparse test.c
test.c:1:15: warning: missing identifier in declaration
test.c:1:15: error: Expected ; at the end of type declaration
test.c:1:15: error: got 1

regards,
dan carpenter
