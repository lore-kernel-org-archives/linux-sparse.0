From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: Remove nested extern
Date: Mon, 22 Sep 2014 21:01:28 +0200
Message-ID: <20140922190128.GA2805@worktop.programming.kicks-ass.net>
References: <CAFLxGvwfuE-458duC9ARMLLMBCvZaBQnwDjPW6uJC4FAViBXjQ@mail.gmail.com>
 <20140922175511.62229.98784.stgit@mdrustad-wks.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140922175511.62229.98784.stgit@mdrustad-wks.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark D Rustad <mark.d.rustad@intel.com>
Cc: sparse@chrisli.org, linux-kernel@vger.kernel.org, richard.weinberger@gmail.com, linux-sparse@vger.kernel.org, mingo@redhat.com, jeffrey.t.kirsher@intel.com, computersforpeace@gmail.com
List-Id: linux-sparse@vger.kernel.org

On Mon, Sep 22, 2014 at 10:55:11AM -0700, Mark D Rustad wrote:
> Avoid W=2 nested-externs warning by moving the nested extern to
> a normal extern. This eliminates that warning which is generated
> for every inclusion of sched.h in a kernel build when W=2 is used.
> This also removes a point of maintenance if the definition of
> delayacct_on were ever to change.
> 

Yeah, so why is that warning worth using? Just disable the warn if
you're bothered by it.
