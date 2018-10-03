From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Sparse warnings from calls to max3() and max
Date: Wed, 3 Oct 2018 13:43:06 -0700
Message-ID: <45c184f7-8e1d-59bd-a448-97675e6de81a@infradead.org>
References: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>, LKML <linux-kernel@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

[adding linux-sparse mailing list]


On 10/2/18 4:44 PM, Larry Finger wrote:
> Hi,
> 
> Sparse has suddenly started issuing as many as 11 warnings of "expression using sizeof(void)" for each call to max3(). There are similar warnings for calls to max(), thus I think this is the origin of the problem. My sparse version is 20180324-1.3-x86_64 installed in openSUSE Tumbleweed. My kernel is 4.19.0-rc6.
> 
> Thanks,
> 
> Larry


-- 
~Randy
