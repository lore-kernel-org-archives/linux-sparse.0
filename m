From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Wed, 24 Sep 2014 16:42:07 +0100
Message-ID: <20140924154207.GD4966@casper.infradead.org>
References: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
 <CANeU7QnRFxZ+OV5G2W3tC+tBnYNNcQsH_YEB=cyHmAfmfYc1PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41852 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaIXPmJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 11:42:09 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QnRFxZ+OV5G2W3tC+tBnYNNcQsH_YEB=cyHmAfmfYc1PQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 09/24/14 at 11:24pm, Christopher Li wrote:
> In stead of patching each test case file. How about teach the
> test-suilte to be smarter? The test-suilte should change the default
> return value to none zero if there is none empty "check-error-start" and
> "check-error-end" section. In other words, if there is expected
> error output, we already guess the returns status is error.
> The test case can still use "check-exit-value" to overwrite the default
> value.
> 
> I expect that can save most of the patching to test case file.

The return value of thest will only be non zero if an actual error
has been detected. It will remain zero if only warnings have been
found. So we would need to parse the text between "check-exit-start"
and "check-error-end" for the string "error:" or something a like
that. I found that to be fragile and the explicit declaration of an
expected failure to be superior as it also verifies whether an
expected warning is properly treated as a warning or not.

