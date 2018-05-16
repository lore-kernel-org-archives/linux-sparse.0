From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC 0/8] Improving compiler inlining decisions
Date: Tue, 15 May 2018 22:48:02 -0500
Message-ID: <20180516034802.nuf7ft65nvtgc65j@treble>
References: <20180515141124.84254-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, nadav.amit@gmail.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

On Tue, May 15, 2018 at 07:11:07AM -0700, Nadav Amit wrote:
> This patch-set deals with an interesting yet stupid problem: code that
> does not get inlined despite its simplicity.

I got the 0/8 patch twice, and didn't get the 1/8 patch.  Was there an
issue with the sending of the patches?

-- 
Josh
