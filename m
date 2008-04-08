From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: My proposed GSoC2008 project.
Date: Tue, 8 Apr 2008 19:06:03 +0400
Message-ID: <f19298770804080806l4fe92334la2c92514ac8b1875@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:51115 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYDHPGE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 Apr 2008 11:06:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1792711wah.23
        for <linux-sparse@vger.kernel.org>; Tue, 08 Apr 2008 08:06:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, James Westby <jw+debian@jameswestby.net>, Christopher Li <sparse@chrisli.org>, Greg KH <greg@kroah.com>

Hello, guys.

So, I have posted my GSoC application yesterday. Sorry for not discussing
it with you on the list. I was a bit busy these weeks, but to be honest, I
was busy not with this project, so I probably could write the same proposal
two weeks ago, and maybe rewrite it depending on the feedback. Anyway,
the application is now written and sent to Google, so there is nothing wrong
if I also send it to the list, right? Last year, when I participated in the GSoC
program for the first time, I started working on my project very early, actually
before the application deadline. This was probably the best decision I made
during that summer of code. As this project seems to be at least as complex
as the one from the last year, I'd also like to start it early, if possible. So
if you like the application, I'd probably take the risk wasting two weeks of
work in case it won't get accepted in the end.

=========================================================

Subject:
	A C code "linker" based on sparse, required to build an advanced
static analyser.

Abstract:

	Right now, sparse is limited mostly to type checking and
	questionable/dubious C constructs. Yet, static code analysis
	may be used to perform lots of wider checks.

	To build an advanced checker, a way to perform inter-module
	references is needed. While my tool for creating the symbol
	database will be working on the source code and not on the
	compiled object files, I'd call in a C linker by the analogue
	to the tasks, performed by a binary linker.

	As time allows, I'd also like to share my thoughts on actually
	creating an advanced checker.

Description:

	Currently, I'm thinking about a static analyser based on
	abstract interpretation, mainly to be used to check for
	buffer overruns and NULL-pointer references. Yet, my
	ideas are still not ready to form a proposal for a summer
	of code project, and probably writing a working implementation
	would also be too big for one.

	Since as at least one person besides me is working on an
	advanced checker and needs a C code linker, I thought it
	would be a good	thing to actually write one. Even if my
	ideas for the global project are not yet fully shaped, the
	linker is one separate and self-sufficient thing that may
	already be written.

	So, as I understand it, the linker should be run by the
	build system as a replacement for $LD and should create
	a database of all the symbols met, with references to their
	locations in the .c files (Well, we'd probably have to copy
	the .c files to .o), so we can actually replace $LD in the
	build system). An other way might be to convert the source
	code to some generic intermediate representation, and actually
	link it into a big "object". While I am considering such a way,
	currently I think it might complicate the further analyser
	development, as people are not very good at reading and
	understanding intermediate code, which would be needed at the
	debugging stage.

	Besides collecting the symbols from the sources, the linker
	should also support the linker scripts, to actually
	allocate the symbols. This is needed to reduce the number
	of false positives from the constructs traversing some
	linking tables, usually used for module initialisation.

	Since the result of running sparse on a c file is already
	a symbol list (with all the details about the symbol's
	body), it should be relatively easy to create a database
	containing the needed information. So, I hope there will
	be some time left to actually do the more interesting work.

	As a minimal result of the project, I see a fully working
	linker, as I described. If some of the sparse developers
	see it working in a different way, I'll probably implement
	both modes.

=========================================================

Also, Greg KH already asked a question in the webapp, so I'll copy it
here.

=========================================================

04/08/08 05:04
Greg Kroah Hartman
I like this proposal.

What kind of background do you have that suggests that you will
be able to achieve this kind of goal within the timeframe of the GSoC
process?


04/08/08 06:04
Alexey Zaytsev
You mean the advanced analyser or the linker?

If the linker, uh, well. I actually consider it as an easy task, and hope to
complete it within a month at most. I have got a good understanding how
a linker works. I have written quite some ld scripts, and have no problems
understanding what is written in the "Linkers and Loaders" book. From the
technical side, the project is also not very hard. The main sparse(file)
function already returns you a list of symbols exported from the parsed file,
so you basically have to run sparse() on all the input files (assuming the .c
were copied to .o) and collect all the resulting symbols. One
not-completely-trivial thing might be the linker script parsing, but it too does
not seem to be too hard to me. So if anything, I fear this project is too simple
for the summer of code. But I hope the mentors would trust that after
completing the linker, I will continue my work on my advanced analyser,
or would join the collaborative effort, if such should arise.

If you mean the creation of the advanced analyser (whatever this could mean ;),
I don't claim it as a certain goal for this summer. I never got a
strong theoretical
computer since/mathematical education, partly because of my own
irresponsibility,
so I'm probably not the right person for this task. But I've got some
ideas, that I
hope to write them down some day. They seems simple enough to me, and right
now I'm looking through the papers published on the subject, mainly to make sure
I'm not reinventing the wheel. So, I hope to plan a better project in
a month or two,
and it is absolutely possible that you will see some practical result.
I just don't
make it a got this summer of code, to not disappoint anyone.

=========================================================


P.S: Please copy any essential questions to the webapp, or ask
people with the proper access rights to do so. I hope the
on-list discussion not to replace, but to accelerate the formal
process.
