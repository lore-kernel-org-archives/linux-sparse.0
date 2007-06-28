From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results
	into test files
Date: Thu, 28 Jun 2007 14:38:53 -0700
Message-ID: <1183066733.2621.127.camel@josh-work.beaverton.ibm.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
	 <20070628054019.30704.64375.stgit@dv.roinet.com>
	 <46836129.7050407@freedesktop.org>
	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60737 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbXF1Vi6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 17:38:58 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5SLcwnX026030
	for <linux-sparse@vger.kernel.org>; Thu, 28 Jun 2007 17:38:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5SLcqdk154284
	for <linux-sparse@vger.kernel.org>; Thu, 28 Jun 2007 15:38:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5SLcqCr018535
	for <linux-sparse@vger.kernel.org>; Thu, 28 Jun 2007 15:38:52 -0600
In-Reply-To: <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Thu, 2007-06-28 at 20:59 +0200, Damien Lespiau wrote:
> I happen to have 3 patches in my tree that look like this one. I
> thought you might
> want to have a look as they appear to handle the points you were wanting to fix.
> Patch 3 is a "documentation patch" that explains what I wanted to do.
> 
> I attached those patches as gmail does not allow me to answer a thread and
> post a patch without losing its formatting.

Will review in more detail later, but at first glance this looks quite
good, and very capable.

Two minor things that jump out at me:
      * The need to specify the command line as "../sparse args $file"
        seems somewhat inelegant.  I do like the ability to specify a
        command other than sparse; for example, this could allow
        checking the output of c2xml.  However, I'd prefer not to need a
        path; how about allowing "sparse args $file"?  Also, allowing an
        alternate option "check-options" that just specifies sparse
        flags seems useful, and the default command could do something
        like "sparse $options $file"; that way, you can just say
        "check-options: -E", or "check-options: -Wthingy".
      * The need to prefix every line of output, rather than delimiting
        the start and end of the output, seems painful with large
        amounts of output.

Other than that, I really like this test suite.  Thanks!

- Josh Triplett
