From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Sparse and the Google Summer of Code 2008
Date: Tue, 11 Mar 2008 15:10:25 -0700
Message-ID: <70318cbf0803111510x2bdb75cct648637e05a89b6b2@mail.gmail.com>
References: <f19298770803111038o3655a216vfe5a4b46876e7218@mail.gmail.com>
	 <47D6CD7F.6010800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:20365 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYCKWK1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Mar 2008 18:10:27 -0400
Received: by wr-out-0506.google.com with SMTP id 50so1579382wra.13
        for <linux-sparse@vger.kernel.org>; Tue, 11 Mar 2008 15:10:26 -0700 (PDT)
In-Reply-To: <47D6CD7F.6010800@kernel.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-sparse@vger.kernel.org

Hi,

I am glad to mentor some projects with sparse.

Here is some project ideas for the checker. I really want to implement some
thing like the Stanford Checker. Here is some hand waving road map:

- Inside function check. I already have some patch does that.
- serialize the compiled c type and linearized byte code so you can
load it as module.
- cross file symbol dictionary look up and reference. aka linker.
- cross file function check.

I can write it into more detailed project requirement and mile stone if there
is interest on this.

Chris


On Tue, Mar 11, 2008 at 11:20 AM, Josh Triplett <josh@kernel.org> wrote:
> Alexey Zaytsev wrote:
>  > Is sparse going to participate in this year's soc?
>  > I e-mailed Josh a day or two ago, but got no answer,
>  > and the org application deadline is May 12, 12:00 PDT.
>  >
>  > I know, last year was not all that successful, but maybe
>  > there will be more applications this year. I've got some
>  > ideas about abstract interpretation for one. I can't promise
>  > that I'll choose sparse, there should be lots of interesting
>  > projects this year, but there are other people as well.
>
>  At least one other person has asked about Sparse and SoC, which
>  suggests that some interest exists.  I'll work on getting the
>  org forms filled out today.
>
>  If anyone else on the Sparse list has an interest in mentoring, please
>  let me know as soon as possible.
>
>  For anyone thinking about project ideas, I'd like to make two general
>  recommendations:
>
>  * Have specific goals, rather than just "improve support for $FOO".
>
>  * Release early, release often.  Please get comfortable with the idea
>   of releasing your work to the Sparse mailing list, regardless of the
>   current state of that work.
>
>  Regarding specific project ideas, I would have a particularly strong
>  interest in projects related to improved context checking (including
>  via abstract interpretation or similar), projects to make it easier to
>  add new checks to Sparse or maintain the existing checks, or projects
>  attempting to port C test suites (such as GCC's) to Sparse.
>
>  (In that last case, many tests will not apply due to the lack of code
>  generation, but if you want to write a code eneration backend do feel
>  free. :)  Also, many tests would still not apply due to lack of
>  specific optimizations.)
>
>  - Josh Triplett
>
>
