From: =?iso-8859-1?Q?Guillaume_Oberl=E9?= <goberle@ygg.tf>
Subject: preop expression and variable
Date: Fri, 21 Mar 2014 12:02:32 +0100
Message-ID: <22AE7E9E-932B-4E83-9DE1-CE82FD140CDF@ygg.tf>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53151 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951AbaCULDH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 21 Mar 2014 07:03:07 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so1444805wes.5
        for <linux-sparse@vger.kernel.org>; Fri, 21 Mar 2014 04:03:05 -0700 (PDT)
Received: from [192.168.205.82] ([160.92.8.31])
        by mx.google.com with ESMTPSA id mw3sm3821587wic.7.2014.03.21.04.03.04
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 04:03:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I'm an intern and I'm working on a project that aims to use sparse to generate a Json AST of an OpenCL code. Inspired by ast-inspect.c, I've started writing a C to Json program for sparse, and I have some issues.

Here is the code : https://gist.github.com/goberle/b867d29c1b833cf55d36 and here is an example of the output : https://gist.github.com/goberle/e3e8e35bf6a05ea86a6d.

If you look at the output (l117 or l133), I have a PreopExpression before every variable in an expression statement, even if I have no preoperator. I wonder if these are usefull, and if so, what they represent ? (EXPR_PREOP case is defined at line 443 in the code)

Thank you for your time and feel free to contact me if you have any other suggestions.

goberle