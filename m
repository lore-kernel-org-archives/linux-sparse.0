From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Date: Sat, 30 Mar 2019 00:12:32 +0100
Message-ID: <20190329231231.suwcypwnyunvysyd@ltop.local>
References: <20190325195303.GA20629@hari-Inspiron-1545>
 <20190327115330.04b5b481@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327115330.04b5b481@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>, mingo@redhat.com, roopa@cumulusnetworks.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Wed, Mar 27, 2019 at 11:53:30AM -0400, Steven Rostedt wrote:
> On Tue, 26 Mar 2019 01:23:03 +0530
> Hariprasad Kelam <hariprasad.kelam@gmail.com> wrote:
> 
> > This patch fixes below spare errors.
> > 
> > Sparse error:
> > make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> > ./include/trace/events/neigh.h:73:1: error: directive in argument list
> > ./include/trace/events/neigh.h:78:1: error: directive in argument list
> > ./include/trace/events/neigh.h:150:1: error: directive in argument list
> > ./include/trace/events/neigh.h:155:1: error: directive in argument list
> > 
> 
> I have nothing really against these patches, but why is the current
> code considered wrong?
> 
> Note, TRACE_EVENTS() are "special macros". They hold structure
> definitions and full code inside the argument list. There should be no
> reason that this is causing a warning.

The problem is that #ifdefs at line 73 & 150 are inside TRACE_EVENT()'s
invocation and this is undefined behaviour. From the standard:
	... If there are sequences of preprocessing tokens within the
	list of arguments that would otherwise act as preprocessing
	directives, the behavior is undefined. 

	[C90 6.8.3, C99 & C11 6.10.3p11]

GCC can handle it (and sparse too) but yes sparse complains about it.

-- Luc Van Oostenryck
